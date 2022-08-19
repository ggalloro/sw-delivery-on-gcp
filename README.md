# Continuous Delivery on GCP Tutorial

This repo contains some example assets to evaluate how to use Google [Cloud Code](https://cloud.google.com/code/docs/shell), [Cloud Build](https://cloud.google.com/build/docs/overview), [Google Cloud Deploy](https://cloud.google.com/deploy/docs/overview) and [Skaffold](https://skaffold.dev/) to automate software delivery and promote releases through multiple stages on GCP.

Using these assets and following the instructions below you could experiment an example flow where:
1. A developer forks the application repo in his Github account
2. The developer make a change to the code using [Cloud Shell Editor and Cloud Code](https://cloud.google.com/code/docs/shell), the change is immediately deployed in his dev cluster running in minikube in the Cloud Shell
3. When he is happy with the change he opens a pull request to the main repo
4. QA team makes a specific comment to the PR and this automatically executes a Cloud Build trigger that build a container with Skaffold, create a relese on Cloud Deploy and rolls it out in a QA GKE cluster where usability tests can be run
5. After the QA team is happy the PR is merged and this runs another trigger that promote the release to a Prod GKE Cluster. The Cloud Deploy prod target requires approval so an approval request is triggered, the App Release team verify the rollout and approves it so the app is released in prduction

## What you need
* A GCP project whit GKE, Cloud Build, Cloud Deploy, Artifact Registry APIs enabled
* A main user account with project owner role on the project that will be used as someone from Platform Team / QA / App Release team 
* A Github account
* An additional Google account that will be used as the 'developer', this account should also have a separate Github account to fork the repo in

## Preparation

1. Create 2 GKE Clusters, one for the QA environment and the other for the prod environment, both in the same location (zone or region).
2. Create an [Artifact Registry](https://cloud.google.com/artifact-registry) Repository to store your images
3. Fork this repo to your Github account and clone locally, this will be the used as the application repo for the demo
4. Run [setup.sh](setup.sh) from the local repo clone and follow prompt to insert your GCP project, cluster names and locations, Artifact Registry repository, Cloud Deploy delivery pipeline region. Then commit and push to your fork.
5. Create a Cloud Deploy [delivery pipeline](https://cloud.google.com/deploy/docs/deploying-application#creating_your_delivery_pipeline) using [the manifest provided](clouddeploy-config/delivery-pipeline.yaml). It will create a pipeline that has qa and prod as stages each using a profile with the same name.
6. Create 2 Cloud Deploy targets mapping the above clusters to the pipeline stages using [this manifest for qa cluster](clouddeploy-config/target-qa.yaml) and [this one for prod cluster](clouddeploy-config/target-prod.yaml).
7. [Create 2 Cloud Build triggers](https://cloud.google.com/build/docs/automating-builds/create-manage-triggers) linked to your fork of the Github repo:
    1. The 1st trigger must be invoked by a pull request with Comment control enabled and use the build-qa.yaml(build-qa.yaml) build config
    2. The 2nd trigger must be invoked by a push to the main branch and  should use the release-prod.yaml(release-prod.yaml) build config
8. Create 1 additional Chrome profile (or use Chrome Incognito windows), this will be used for the developer tasks, from this Chrome profile or window:
    1. Log in to the additional Github account
    2. Create another fork of the repo from the one forked by the main account
    3. Log in to Google Cloud Shell
    4. Clone the fork of the repo locally
    5. Configure personal access token for Github account
    6. Launch Cloud Shell Editor



## Execution

1. From the developer account Chrome window launch Cloud Shell Editor if not already done   