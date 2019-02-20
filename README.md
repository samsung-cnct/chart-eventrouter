# Heptio Labs Eventrouter Helm Chart

[![Build Status][1]](https://jenkins.migrations.cnct.io/job/pipeline-eventrouter/job/master)

[Eventrouter][2] deployment for Kubernetes, using this [helm chart][3] and this [Dockerfile][4].

The event router serves as an active watcher of event resource in the kubernetes system, which takes those events and pushes them to a user specified sink. This is useful for a number of different purposes, but most notably long term behavioral analysis of your workloads running on your kubernetes cluster.

Eventrouter is configured to write the events to stdout. In CNCT use, (fluentbit) forwards the stdout events to Elasticsearch.

## How to install on running Kubernetes cluster with `helm`

Prerequisites: helm, [tiller][5]

    helm repo add cnct https://charts.cnct.io
    helm repo update
    helm install cnct/eventrouter

## To install from local repository from `/chart-eventrouter/charts`

    helm install --name my-release --namespace my-namespace ./eventrouter

[1]: https://jenkins.migrations.cnct.io/buildStatus/icon?job=pipeline-eventrouter/master
[2]: https://github.com/heptiolabs/eventrouter
[3]: https://quay.io/application/samsung_cnct/eventrouter
[4]: https://github.com/samsung-cnct/chart-eventrouter/blob/master/rootfs/eventrouter/Dockerfile
[5]: https://docs.helm.sh/using_helm/
