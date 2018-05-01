#! /usr/local/bin/bash -ex
# don't regenerate secrets for staging if they are already present
if kubectl get secret eventrouter-client-tls -n staging; then
  exit 0;
fi

export PATH=$PATH:/usr/local/go/bin:/go/bin
export GOPATH=/go

# setup tls for eventrouter
export GEN_NAMESPACE="${PIPELINE_STAGE_NAMESPACE}"
export GEN_CLIENT_SECRET_NAME="eventrouter-client-tls"
export GEN_STATEFULSET_NAME_VAULT="eventrouter-${PIPELINE_TEST_NAMESPACE}"
export GEN_ACCESS_SERVICE_NAME="${GEN_STATEFULSET_NAME_VAULT}-access"
export GEN_IDENTITY_SERVICE_NAME=${GEN_STATEFULSET_NAME_VAULT}
export GEN_MAX_PODS=3

# create the namespace
echo "Creating namespace ${GEN_NAMESPACE}"
kubectl create namespace ${GEN_NAMESPACE} || true

# generate tls secrets for eventrouter in GEN_NAMESPACE
echo "Generating etcd TLS certificates"
${PIPELINE_WORKSPACE}/charts/eventrouter/tls-generator/generate-certs.sh
