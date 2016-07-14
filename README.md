# Concourse CI Azure Cluster Deployment
Deploy [Concourse CI](https://concourse.ci/) on Azure using [BOSH](http://bosh.io/)

## Overview

- Prepare the Environment
  - Initialise a BOSH Director
    - Azure Account (Create/Use)
    - Azure Service Principal
      - [BOSH:Create a Service Principal - Azure CLI](https://github.com/cloudfoundry-incubator/bosh-azure-cpi-release/blob/master/docs/get-started/create-service-principal.md)
  - Set up bosh Cloud Config
  - Upload the stemcell
- Deploying Concourse
  - Download Concourse
  - Upload Concourse to the BOSH Director
  - Create Concourse BOSH deployment manifest
  - Deploy Concourse

## Prepare the Environment
### Initialise a BOSH Director
#### Azure Account

## Deploying Concourse
