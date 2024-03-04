#!/bin/bash
echo "Building image for 1st release"
echo
###
skaffold build --default-repo=europe-west1-docker.pkg.dev/kyr-sandbox-test-sma/repertoire-cicd --file-output=artifacts.json
###
echo "Creating 1st release"
echo
gcloud deploy releases create first-release --delivery-pipeline cd-on-gcp-pipeline --region europe-west1 --build-artifacts artifacts.json
###
echo "Release creation completed, please promote and approve your release manually"
