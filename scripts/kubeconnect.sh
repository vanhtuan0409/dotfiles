#!/bin/env bash

BRIDGE_NAME="br-9cd8b847e9fc"
COREDNS_IP=$(kubectl --context minikube get svc -n kube-system kube-dns -o json | jq -r .spec.clusterIP)

sudo ip route add 10.244.0.0/16 via $(minikube ip)
sudo ip route add 10.96.0.0/12 via $(minikube ip)
sudo resolvectl dns $BRIDGE_NAME $COREDNS_IP
sudo resolvectl domain $BRIDGE_NAME svc.cluster.local

