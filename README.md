# Concourse CI Azure Cluster Deployment
Deploy [Concourse CI](https://concourse.ci/) on Azure using [BOSH](http://bosh.io/)

Based on the Concourse CI [Clusters with BOSH](https://concourse.ci/clusters-with-bosh.html) documentation this repository aims to provide an automated creation of a scalable cluster with health management and rolling upgrades! It is very much a work in progress and you should not expect too much of it just now!

## Docker Containers

Scripts in this repository will utilise [Docker](https://www.docker.com) containers rather than install tools on the local machine so the only real requirement is a machine running Docker.

## Overview

- Prepare the Environment
  - Initialise a BOSH Director
    - Azure Account (Create/Use)
    - [Azure Service Principal](docs/azure-service-principal.md)
      - [Create a Service Principal - Azure CLI](https://github.com/cloudfoundry-incubator/bosh-azure-cpi-release/blob/master/docs/get-started/create-service-principal.md)
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
