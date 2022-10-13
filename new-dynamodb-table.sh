#!/bin/bash

aws dynamodb create-table \
    --table-name Feedback \
    --attribute-definitions \
        AttributeName=Id,AttributeType=S \
        AttributeName=Email,AttributeType=S \
    --key-schema \
        AttributeName=Email,KeyType=HASH \
        AttributeName=Id,KeyType=RANGE \
    --provisioned-throughput \
        ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --table-class STANDARD

