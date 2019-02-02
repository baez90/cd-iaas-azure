#!/usr/bin/env bash

# Used to update the image reference of the scaleset
# az vmss update -n cd-iaas-scaleset -g CD_IaaS --set virtualMachineProfile.storageProfile.imageReference.id=az image show -g CD_IaaS -n "Hackathon-$1" --query "{id:id}" -o tsv

for instanceId in $(az vmss list-instances -n cd-iaas-scaleset -g CD_IaaS --query "[].{id:instanceId}" -o tsv); do
    echo "Updating instance $instanceId"
    az vmss update-instances -n cd-iaas-scaleset -g CD_IaaS --instance-ids ${instanceId}
done