#! /usr/local/bin/bash -ex
# setup golang
echo "Setting up golang"
wget https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz
mkdir -p /go
export PATH=$PATH:/usr/local/go/bin:/go/bin
export GOPATH=/go
mkdir -p /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
apk add --no-cache --virtual .build-deps gcc build-base libtool sqlite-dev git curl

# setup cloudflare ssl
echo "Setting up cloudflare SSL tools"
go get -u github.com/cloudflare/cfssl/cmd/cfssl
go get -u github.com/cloudflare/cfssl/cmd/cfssljson

# setup kubectl
echo "Setting up kubectl"
wget https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

# setup tls for etcd
export GEN_CLUSTER_SIZE=3
export GEN_NAMESPACE="${PIPELINE_TEST_NAMESPACE}"
export GEN_SERVER_SECRET_NAME="etcd-server-tls"
export GEN_PEER_SECRET_NAME="etcd-peer-tls"
export GEN_CLIENT_SECRET_NAME="etcd-client-tls"
export GEN_STATEFULSET_NAME="etcd-eventrouter"
export GEN_CLUSTER_DOMAIN="cluster.local"

echo "Cloning etcd chart repository"
git clone https://github.com/samsung-cnct/chart-eventrouter-etcd.git ${PIPELINE_WORKSPACE}/etcd  --depth 1

# create the namespace
echo "Creating namespace ${PIPELINE_TEST_NAMESPACE}"
kubectl create namespace ${PIPELINE_TEST_NAMESPACE} || true

# generate tls secrets for etcd in GEN_NAMESPACE
echo "Generating etcd TLS certificates"
${PIPELINE_WORKSPACE}/etcd/charts/eventrouter-etcd/tls-generator/generate-certs.sh

# setup tls for eventrouter
export GEN_NAMESPACE="${PIPELINE_TEST_NAMESPACE}"
export GEN_CLIENT_SECRET_NAME="eventrouter-client-tls"
export GEN_STATEFULSET_NAME_VAULT="eventrouter-${PIPELINE_TEST_NAMESPACE}"
export GEN_ACCESS_SERVICE_NAME="${GEN_STATEFULSET_NAME_VAULT}-access"
export GEN_IDENTITY_SERVICE_NAME=${GEN_STATEFULSET_NAME_VAULT}
export GEN_MAX_PODS=3

# generate tls secrets for eventrouter in GEN_NAMESPACE
echo "Generating etcd TLS certificates"
${PIPELINE_WORKSPACE}/charts/eventrouter/tls-generator/generate-certs.sh
