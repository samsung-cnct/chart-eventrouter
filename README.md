# Eventrouter Deployment for Kubernetes Logging
[![pipeline status](https://git.cnct.io/common-tools/samsung-cnct_chart-eventrouter/badges/master/pipeline.svg)](https://git.cnct.io/common-tools/samsung-cnct_chart-eventrouter/commits/master)

[Eventrouter](https://github.com/heptiolabs/eventrouter) deployment for Kubernetes
logging. The helm chart and docker image for this repository are located at:
https://quay.io/application/samsung_cnct/eventrouter and
https://quay.io/repository/samsung_cnct/eventrouter-container respectively.

The eventrouter is used to watch for kubernetes apiserver events.  Eventrouter is
configured to write the events to stdout.  Our logging component (fluentbit or 
fluentd) forwards the stdout events to Elasticsearch.

### To install this chart
    helm registry install quay.io/samsung_cnct/eventrouter


### Developers: To install local changes
    cp build/Chart.yaml.in eventrouter/Chart.yaml
    cd eventrouter
    vi Chart.yaml
       version: 0.1.0-a

    Option 1: create a kubernetes yaml file from the chart data.
    helm install --name=eventrouter -f values.yaml . --dry-run --debug > er.yaml
    vi er.yaml
       Delete lines before MANIFEST
    kubectl create -f er.yaml

    Option 2: install the chart into kubernetes
    helm install --name=eventrouter -f values.yaml .  
    
