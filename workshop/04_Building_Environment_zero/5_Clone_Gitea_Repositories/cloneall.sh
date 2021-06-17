#!/bin/bash

YLW='\033[1;33m'
GRN='\033[0;32m'
NC='\033[0m'

if [ -z $1 ]
then
    echo "Please provide Gitea URL"
    echo ""
    echo "$ ./cloneall.sh http://gitea.<IP-ADDRESS>.nip.io"
    exit 1
fi

GITEA_URL=$(echo $1 | xargs | sed -e 's/\/$//')

GITEA_ORG=$GITEA_URL/sockshop

HTTP_RESPONSE=`curl -k -s -o /dev/null -I -w "%{http_code}" $GITEA_ORG`

if [ $HTTP_RESPONSE -ne 200 ]
then
	echo "GitHub organization doesn't exist - $GITEA_ORG - HTTP status code $HTTP_RESPONSE"
	exit 1
fi

declare -a repositories=( $(curl -k -s $GITEA_URL/api/v1/orgs/sockshop/repos | jq -r '.[].name') )

if [ ${#repositories[@]} -eq 0 ]
then
    echo "No GitHub repositories found in sockshop"
    exit 1
fi

mkdir sockshop
cd sockshop

for repo in "${repositories[@]}"
do
	echo -e "${YLW}Cloning $GITEA_ORG/$repo ${NC}"
	git -c http.sslVerify=false clone -q "$GITEA_ORG/$repo"
	echo -e "${YLW}Done. ${NC}"
done

echo ""
echo -e "${GRN}The repositories have been cloned to:${NC} ${PWD}"
echo ""
cd ..