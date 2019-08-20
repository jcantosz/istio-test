export ISTIO_VERSION="1.2.2"
curl -L https://git.io/getLatestIstio | sh -

ISTIO_PATH="$PWD/istio-$ISTIO_VERSION"

export PATH=$ISTIO_PATH/bin:$PATH

kubectl create namespace istio-system
helm template $ISTIO_PATH/install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -

helm template $ISTIO_PATH/install/kubernetes/helm/istio --name istio --namespace istio-system \
    --values $ISTIO_PATH/install/kubernetes/helm/istio/values-istio-minimal.yaml \
    --set gateways.enabled=true | kubectl apply -f -
