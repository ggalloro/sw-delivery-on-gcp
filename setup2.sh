#!/bin/bash
# This version of the script works only with GNU sed
# If using a mac, please run setup.sh
echo "Continuous Delivery on GCP demo setup"
echo
###
echo "Enter your GCP project ID:"
read yourproject
sed -i "s/yourproject/$yourproject/g" clouddeploy-config/target-prod.yaml
sed -i "s/yourproject/$yourproject/g" clouddeploy-config/target-qa.yaml
###
echo "Enter the location (zone or region) of your GKE clusters:"
read yourlocation
sed -i "s/yourlocation/$yourlocation/g" clouddeploy-config/target-prod.yaml
sed -i "s/yourlocation/$yourlocation/g" clouddeploy-config/target-qa.yaml
###
echo "Enter the name choosen for your GKE qa cluster (for example qa-cluster):"
read qacluster
sed -i "s/qacluster/$qacluster/g" clouddeploy-config/target-qa.yaml
###
echo "Enter the name choosen for your GKE prod cluster (for example prod-cluster):"
read prodcluster
sed -i "s/prodcluster/$prodcluster/g" clouddeploy-config/target-prod.yaml
###
echo "Enter the name of your GCP region (the one you will create the delivery pipeline in):"
read yourregion
sed -i "s/yourregion/$yourregion/g" build-qa.yaml
sed -i "s/yourregion/$yourregion/g" release-prod.yaml
###
echo "Enter the full path of your Artifact Registry repository:"
read yourrepo
sed -i "s,yourrepo,$yourrepo,g" build-qa.yaml
###
echo "Configuration successfully updated"
