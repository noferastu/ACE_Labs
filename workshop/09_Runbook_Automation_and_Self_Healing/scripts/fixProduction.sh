#!/bin/bash

# Created by Andrew Knackstedt for ACL.
# Ensure that the environment has all of then necessary folders.
declare -a arr=("manifests-istio/" "repositories/k8s-deploy-production/istio/" "repositories/sockshop-infrastructure/manifests/" "repositories/k8s-deploy-production/")
for DIR in "${arr[@]}"
do
    if [ ! -d $DIR ]
    then
        echo "Your environment does not seem to be set up correctly."
        echo "You need to run this script from your home directory."
        echo "Detected a missing directory:" $DIR
        exit 1
    fi
done

# Begin the cleanup process.
echo "Starting Cleanup!"

# Clean and re-generate the production pipeline.
kubectl delete namespace production
kubectl create namespace production
kubectl create -f repositories/k8s-deploy-production/.
kubectl apply -f repositories/sockshop-infrastructure/manifests/.

# Have the user re-build the production pipeline from Jenkins.
echo "Run the k8s-deploy-production pipeline from jenkins. (Should take about a minute.)"
echo "<Jenkins Host URL>/job/k8s-deploy-production/ -> Build Now"
echo "Press Enter(Return) to proceed."
read varname

# Re-spawn the pods after the re-building from Jenkins.
kubectl delete pods -n production --all

# Re-spawn the istio-system.
kubectl delete namespace istio-system
kubectl label namespace production istio-injection=enabled
kubectl apply -f manifests-istio/.
kubectl apply -f repositories/k8s-deploy-production/istio/.


echo "Completed. Your production pods should be running properly."
echo "You need to wait about 2~3 minutes for all of the pods to finish starting up before the page loads correctly."
