#!/bin/bash

if [ "" == "$NS" ]; then
   NS="default"
else
   NS="$NS" 
fi

if [ "" == "$REPLICA" ]; then
   REPLICA=1
fi

if [ "" == "$TAG" ]; then
   TAG="latest"
fi

helm upgrade --install first-server sample-app-0.1.0.tgz --namespace $NS --set nodeName=$NODE --set replicaCount=$REPLICA --set fullnameOverride="first-server" --set service.type=NodePort --set image.tag=$TAG

helm upgrade --install second-server sample-app-0.1.0.tgz --namespace $NS --set nodeName=$NODE --set replicaCount=$REPLICA --set fullnameOverride="second-server" --set variables.grpc.value="first-server" --set variables.http.value="first-server" --set service.type=NodePort --set image.tag=$TAG

helm upgrade --install third-server sample-app-0.1.0.tgz --namespace $NS --set nodeName=$NODE --set replicaCount=$REPLICA --set fullnameOverride="third-server" --set variables.grpc.value="second-server" --set variables.http.value="second-server" --set service.type=NodePort --set image.tag=$TAG

helm upgrade --install forth-server sample-app-0.1.0.tgz --namespace $NS --set nodeName=$NODE --set replicaCount=$REPLICA --set fullnameOverride="forth-server" --set variables.grpc.value="third-server" --set variables.http.value="third-server" --set service.type=NodePort --set image.tag=$TAG

helm upgrade --install frontend-server sample-app-0.1.0.tgz --namespace $NS --set nodeName=$NODE --set replicaCount=$REPLICA --set fullnameOverride="frontend-server" --set variables.grpc.value="forth-server" --set variables.http.value="forth-server" --set service.type=NodePort --set image.tag=$TAG
