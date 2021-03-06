#!/bin/bash -x
version=$1
echo $version
generate_post_data()
{
cat  <<EOF
{
 "metadata": {
    "annotations": {
    "$1": "$2"
    }
 }
}
EOF
}
NODE=${MY_NODE_NAME}
BASE_URL=$1
KEY=/etc/kubernetes/pki/apiserver-kubelet-client.key
CERT=/etc/kubernetes/pki/apiserver-kubelet-client.crt
TOKEN=${SA_TOKEN}

/usr/bin/curl --header "Authorization: Bearer $TOKEN" --insecure --request PATCH -H 'Content-Type: application/merge-patch+json' -H 'Accept: application/json' --data "$(generate_post_data $2 $3)" $BASE_URL/api/v1/nodes/$NODE