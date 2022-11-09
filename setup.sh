#!/bin/bash
echo "Continuous Delivery on GCP demo setup"
echo
###
echo "Enter your GCP project ID:"
read yourproject
sed -i.bak "s/yourproject/$yourproject/g" clouddeploy-config/target-prod.yaml
sed -i.bak "s/yourproject/$yourproject/g" clouddeploy-config/target-qa.yaml
###
echo "Enter the location (zone or region) of your GKE clusters:"
read yourlocation
sed -i.bak "s/yourlocation/$yourlocation/g" clouddeploy-config/target-prod.yaml
sed -i.bak "s/yourlocation/$yourlocation/g" clouddeploy-config/target-qa.yaml
###
echo "Enter the name choosen for your GKE qa cluster (for example qa-cluster):"
read qacluster
sed -i.bak "s/qacluster/$qacluster/g" clouddeploy-config/target-qa.yaml
###
echo "Enter the name choosen for your GKE prod cluster (for example prod-cluster):"
read prodcluster
sed -i.bak "s/prodcluster/$prodcluster/g" clouddeploy-config/target-prod.yaml
###
echo "Enter the name of your GCP region (the one you will create the delivery pipeline in):"
read yourregion
sed -i.bak "s/yourregion/$yourregion/g" build-qa.yaml
sed -i.bak "s/yourregion/$yourregion/g" release-prod.yaml
###
echo "Enter the full path of your Artifact Registry repository:"
read yourrepo
sed -i.bak "s,yourrepo,$yourrepo,g" build-qa.yaml
###
rm -rf clouddeploy-config/target-prod.yaml.bak
rm -rf clouddeploy-config/target-qa.yaml.bak
rm -rf build-qa.yaml.bak
rm -rf release-prod.yaml.bak
###
echo "Configuration successfully updated"
