curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.2.2 sh -

export PATH=$PWD/istio-1.2.2/bin:$PATH

kubectl create namespace istio-system
helm template install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -

helm template install/kubernetes/helm/istio --name istio --namespace istio-system \
    --values install/kubernetes/helm/istio/values-istio-minimal.yaml \
    --set gateways.enabled=true | kubectl apply -f -
