# Cloud Deploy with Helm

This repo contains some example assets to evaluate how to use Google [Cloud Code](https://cloud.google.com/code/docs/shell), [Cloud Build](https://cloud.google.com/build/docs/overview) and [Google Cloud Deploy](https://cloud.google.com/deploy/docs/overview) to automate software delivery and promote releases through multiple stages.




## Preparation


1. Create 2 GKE Clusters, one for the qa environment and the other for the prod environment, both in the same location (zone or region).
2. Create an [Artifact Registry](https://cloud.google.com/artifact-registry) Repository to store your images
3. Fork this repo and clone locally
4. Run [setup.sh](setup.sh) from the local repo clone and follow prompt to insert your GCP project, cluster names and locations, Artifact Registry repository, Cloud Deploy delivery pipeline region. Then commit and push to your fork.
5. 
6. Create a Cloud Deploy [delivery pipeline](https://cloud.google.com/deploy/docs/deploying-application#creating_your_delivery_pipeline) that has qa and prod as stages each using a profile with the same name ([here an example manifest you can use](clouddeploy-config/delivery-pipeline.yaml))
7. Create 2 Cloud Deploy targets mapping the above clusters to the pipeline stages (here example manifests for [qa](clouddeploy-config/target-qa.yaml) and [prod](clouddeploy-config/target-prod.yaml), that needs to be customized with your cluster names, project and locations)


## Execution



1. Clone this repo and move inside the repo folder
2. Build your application with [skaffold](https://skaffold.dev/) (not required but easier for a quick test, in a real CD pipeline this can be done with anything producing a container image), example command:

	


```
skaffold build --default-repo PATH_OF_YOUR_ARTIFACT_REGISTRY_REPO \ 
--file-output=artifacts.json
```



3. Check that the` skaffold-helm` image has been created in your repository
4. Create a Cloud Deploy release for your application, this will also deploy your release in the `qa` environment, example command:


```
gcloud deploy releases create skaffold-helm --delivery-pipeline cd-on-gcp-pipeline \
--region YOUR_REGION --build-artifacts artifacts.json
```



5. In GCP Console - Cloud Deploy check that your rollout has completed in `qa` environment
6. On your `qa` cluster, check that you have the skaffold-helm deployment with 1 replica:


```
➜  ~ k get deploy
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
skaffold-helm   1/1     1            1           112s
```



7. In GCP Console - Cloud Deploy [Promote](https://cloud.google.com/deploy/docs/deploying-application#promoting_a_release) your release to the `prod` stage
8. In GCP Console - Cloud Deploy check that your rollout has completed in `prod` stage
9. On your prod cluster, check that you have the `skaffold-helm` deployment with 3 replicas:


```
k --context=prod-cluster get deploy
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
skaffold-helm   3/3     3            3           64s
```