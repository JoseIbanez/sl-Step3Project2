#!/bin/bash
set -e



aws s3api create-bucket \
    --bucket $BUCKETNAME \
    > out/web-s3.json
    
envsubst < bucket_policy.json > out/bucket_policy.json

aws s3api put-bucket-policy --bucket $BUCKETNAME --policy file://out/bucket_policy.json

aws s3 website s3://$BUCKETNAME/ --index-document index.html --error-document error.html



# Upload files
aws s3 sync $HOME/Projects/sl/csb-i36iel/ s3://$BUCKETNAME/csb-i36iel/ \
    --exclude '.git/*' 
aws s3 cp $HOME/Projects/sl/csb-i36iel/index.html s3://$BUCKETNAME/


# Open web page
open -a "Google Chrome" "http://$BUCKETNAME.s3-website-us-east-1.amazonaws.com/"


# Create cloudfront distribution 

aws cloudfront create-distribution \
    --origin-domain-name "$BUCKETNAME.s3-website-us-east-1.amazonaws.com" \
    --default-root-object index.html \
    > out/cloudfront.json    

    