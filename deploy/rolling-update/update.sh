#!/usr/bin/env bash

# az vmss update -n cd-iaas-scaleset -g CD_IaaS --set virtualMachineProfile.storageProfile.imageReference.id=az image show -g CD_IaaS -n "Hackathon-$1" --query "{id:id}" -o tsv

for instanceId in $(az vmss list-instances -n cd-iaas-scaleset -g CD_IaaS --query "[].{id:id}" -o tsv); do
    az vmss update-instances -n cd-iaas-scaleset -g CD_IaaS --instance-ids ${instanceId}
done