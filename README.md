# Eventrouter Deployment for Kubernetes Logging
[![Build Status](https://jenkins.migrations.cnct.io/buildStatus/icon?job=pipeline-eventrouter/master)](https://jenkins.migrations.cnct.io/job/pipeline-eventrouter/job/master)

[Eventrouter](https://github.com/heptiolabs/eventrouter) deployment for Kubernetes
logging. It uses this [helm chart](https://quay.io/application/samsung_cnct/eventrouter) and this [Dockerfile](https://github.com/samsung-cnct/chart-eventrouter/blob/master/rootfs/eventrouter/Dockerfile). 

The eventrouter is used to watch for kubernetes apiserver events.  Eventrouter is
configured to write the events to stdout.  Our logging component (fluentbit) forwards the stdout events to Elasticsearch.

## How to install on running Kubernetes cluster with `helm`
Ensure that you have helm and [tiller](https://docs.helm.sh/using_helm/) installed. 
### From our chart repository
``` 
helm repo add cnct https://charts.migrations.cnct.io
helm repo update
helm install cnct/eventrouter
```  
### To install from local repository from `/chart-eventrouter/charts`

```
helm install --name my-release --namespace my-namespace ./eventrouter
```