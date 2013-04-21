#!/bin/bash

# some code ripped from these examples:
# http://stackoverflow.com/questions/9667390/how-to-automatically-snapshot-a-volume-of-an-amazon-ec2-instance
# https://forums.aws.amazon.com/message.jspa?messageID=266893

INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`

TMP_FILE=/tmp/ec2-volume-backup-$RANDOM

$EC2_BIN/ec2-describe-volumes -C $EC2_CERT -K $EC2_PRIVATE_KEY > $TMP_FILE

VOLUME_LIST=$(cat $TMP_FILE | grep ${INSTANCE_ID} | awk '{ print $2 }')

sync

for volume in $(echo $VOLUME_LIST); do
   NAME=$(cat $TMP_FILE | grep Name | grep $volume | awk '{ print $5 }')
   DESC=$NAME-$(date +%m-%d-%Y)
   ec2-create-snapshot -C $EC2_CERT -K $EC2_PRIVATE_KEY -d $DESC $volume
done

rm -rf $TMP_FILE