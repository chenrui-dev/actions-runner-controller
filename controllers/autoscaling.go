package controllers

import (
	"context"
	"fmt"
	"github.com/summerwind/actions-runner-controller/api/v1alpha1"
	"strings"
)

type NotSupported struct {
}

var _ error = NotSupported{}

func (e NotSupported) Error() string {
	return "Autoscaling is currently supported only when spec.repository is set"
}

func (r *RunnerDeploymentReconciler) determineDesiredReplicas(rd v1alpha1.RunnerDeployment) (*int, error) {
	if rd.Spec.Replicas != nil {
		return nil, fmt.Errorf("bug: determineDesiredReplicas should not be called for deplomeny with specific replicas")
	} else if rd.Spec.MinReplicas == nil {
		return nil, fmt.Errorf("runnerdeployment %s/%s is missing minReplicas", rd.Namespace, rd.Name)
	} else if rd.Spec.MaxReplicas == nil {
		return nil, fmt.Errorf("runnerdeployment %s/%s is missing maxReplicas", rd.Namespace, rd.Name)
	}

	var replicas int

	repoID := rd.Spec.Template.Spec.Repository
	if repoID == "" {
		return nil, NotSupported{}
	}

	repo := strings.Split(repoID, "/")
	user, repoName := repo[0], repo[1]
	list, _, err := r.GitHubClient.Actions.ListRepositoryWorkflowRuns(context.TODO(), user, repoName, nil)
	if err != nil {
		return nil, err
	}

	var total, inProgress, queued, completed, unknown int

	for _, r := range list.WorkflowRuns {
		total++

		// In May 2020, there are only 3 statuses.
		// Follow the below links for more details:
		// - https://developer.github.com/v3/actions/workflow-runs/#list-repository-workflow-runs
		// - https://developer.github.com/v3/checks/runs/#create-a-check-run
		switch r.GetStatus() {
		case "completed":
			completed++
		case "in_progress":
			inProgress++
		case "queued":
			queued++
		default:
			unknown++
		}
	}

	minReplicas := *rd.Spec.MinReplicas
	maxReplicas := *rd.Spec.MaxReplicas
	necessaryReplicas := queued + inProgress

	var desiredReplicas int

	if necessaryReplicas < minReplicas {
		desiredReplicas = minReplicas
	} else if necessaryReplicas > maxReplicas {
		desiredReplicas = maxReplicas
	} else {
		desiredReplicas = necessaryReplicas
	}

	rd.Status.Replicas = &desiredReplicas
	replicas = desiredReplicas

	r.Log.V(1).Info(
		"Calculated desired replicas",
		"computed_replicas_desired", desiredReplicas,
		"spec_replicas_min", minReplicas,
		"spec_replicas_max", maxReplicas,
		"workflow_runs_completed", completed,
		"workflow_runs_in_progress", inProgress,
		"workflow_runs_queued", queued,
		"workflow_runs_unknown", unknown,
	)

	return &replicas, nil
}
