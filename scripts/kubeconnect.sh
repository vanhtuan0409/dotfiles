#!/bin/env bash

BRIDGE_NAME="br-48500e4d6c58"
COREDNS_IP=$(kubectl --context minikube get svc -n kube-system kube-dns -o json | jq -r .spec.clusterIP)

sudo ip route add 10.244.0.0/16 via $(minikube ip)
sudo ip route add 10.96.0.0/12 via $(minikube ip)
sudo resolvectl dns $BRIDGE_NAME $COREDNS_IP
sudo resolvectl domain $BRIDGE_NAME svc.cluster.local

