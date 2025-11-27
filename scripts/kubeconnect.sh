#!/bin/env bash

function get_coredns_ip() {
  minikube kubectl -- get svc -n kube-system kube-dns -o json | jq -r .spec.clusterIP
}

function get_svc_cidr() {
  minikube kubectl -- get cm -n kube-system kubeadm-config -o json \
    | jq -r .data.ClusterConfiguration \
    | grep serviceSubnet \
    | sed 's/[[:space:]]*serviceSubnet:[[:space:]]*//'
}

function get_pod_cidr() {
  minikube kubectl -- get cm -n kube-system kubeadm-config -o json \
    | jq -r .data.ClusterConfiguration \
    | grep podSubnet \
    | sed 's/[[:space:]]*podSubnet:[[:space:]]*//'
}

function get_bridge_name() {
  virsh net-info mk-minikube \
    | grep Bridge \
    | sed 's/Bridge:[[:space:]]*//'
}

BRIDGE_NAME="br-3847d56aaf0d"
MINIKUBE_IP=$(minikube ip)
COREDNS_IP=`get_coredns_ip`
SVC_CIDR=`get_svc_cidr`
POD_CIDR=`get_pod_cidr`

echo "using bridge name:  $BRIDGE_NAME"
echo "using minikube ip:  $MINIKUBE_IP"
echo "using coredns ip:   $COREDNS_IP"
echo "using svc cidr:     $SVC_CIDR"

sudo ip route add $POD_CIDR via $MINIKUBE_IP
sudo ip route add $SVC_CIDR via $MINIKUBE_IP
sudo resolvectl dns $BRIDGE_NAME $COREDNS_IP
sudo resolvectl domain $BRIDGE_NAME svc.cluster.local
