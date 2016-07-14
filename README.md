# Concourse CI Azure Cluster Deployment
Deploy [Concourse CI](https://concourse.ci/) on Azure using [BOSH](http://bosh.io/)

- Prepare the Environment
  - Initialise a BOSH Director
    - Azure Account (Create/Use)
    - Azure Service Principal
  - Set up bosh Cloud Config
  - Upload the stemcell
- Deploying Concourse
  - Download Concourse
  - Upload Concourse to the BOSH Director
  - Create Concourse BOSH deployment manifest
  - Deploy Concourse
