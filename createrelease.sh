#!/bin/bash
echo "Building image for 1st release"
echo
###
skaffold build --default-repo=yourrepo --file-output=artifacts.json
###
echo "Creating 1st release"
echo
gcloud deploy releases create first-release --delivery-pipeline cd-on-gcp-pipeline --region yourregion --build-artifacts artifacts.json
###
echo "Release creation completed, please promote and approve your release manually"
