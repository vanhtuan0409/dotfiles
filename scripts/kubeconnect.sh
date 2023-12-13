#!/bin/env bash

BRIDGE_NAME="br-a62516052655"

sudo ip route add 10.244.0.0/16 via $(minikube ip)
sudo ip route add 10.96.10.0/24 via $(minikube ip)
sudo resolvectl dns $BRIDGE_NAME 10.96.10.10
sudo resolvectl domain $BRIDGE_NAME svc.cluster.local

