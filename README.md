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
