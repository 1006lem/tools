#!/bin/bash


curl -L https://istio.io/downloadIstio | sh -
# cd istio-1.18.0
cd istio-*

export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

# Deploy the sample application
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get services
kubectl get pods



kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
istioctl analyze

# Determining the ingress IP and ports
kubectl get svc istio-ingressgateway -n istio-system

# node port setting
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')

# create firewall rules 
export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')

# Set GATEWAY_URL:
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

# Ensure an IP address and port were successfully assigned to the environment variable:
echo "$GATEWAY_URL" 

echo "open http://$GATEWAY_URL/productpage in browser" 


# ----------------------------------------------------------
# install kiali, ...
kubectl apply -f samples/addons
kubectl rollout status deployment/kiali -n istio-system
# access the Kiali dashboard
istioctl dashboard kiali
echo "open http://localhost:20001/kiali in browser" 

# traffic generate
for i in $(seq 1 100); do curl -s -o /dev/null "http://$GATEWAY_URL/productpage"; done
