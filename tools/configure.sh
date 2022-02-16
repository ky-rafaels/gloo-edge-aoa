#!/bin/bash
set -e

# note that the character '_' is an invalid value if you are replacing the defaults below
cluster_context="cluster1"

# check to see if defined contexts exist
if [[ $(kubectl config get-contexts | grep ${cluster_context}) == "" ]]; then
  echo "Check Failed: a current context named ${cluster_context} does not exist. Please check to see if you have this available"
  echo "Run 'kubectl config get-contexts' to see currently available contexts. If the clusters are available, please make sure that they are named correctly. Default is set to cluster1"
  exit 1;
fi

# configure app of apps
kubectl apply -f ../platform-owners/demo/demo-apps.yaml --context ${cluster_context}
kubectl apply -f ../platform-owners/demo/demo-cluster-config.yaml --context ${cluster_context}
kubectl apply -f ../platform-owners/demo/demo-edge-config.yaml --context ${cluster_context}
kubectl apply -f ../platform-owners/demo/demo-infra.yaml --context ${cluster_context}
