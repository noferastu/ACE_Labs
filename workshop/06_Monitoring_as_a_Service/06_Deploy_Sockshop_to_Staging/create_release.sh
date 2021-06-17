#!/bin/bash

version=`cat version`

git checkout -b release/$version
git push -u origin release/$version 

git checkout master

minor_version=`cat version | cut -d'.' -f2`
new_minor_version=$((minor_version+1))
sed -i 's/\.'"$minor_version"'\..*/\.'"$new_minor_version"'\.0/' version
new_version=`cat version`

echo $new_version

git add version
git commit -m "bump version to ${new_version}"
git push origin master