#!/usr/bin/env bash
USER=galaxy
for uid in {1001..1500}
do
   adduser $USER$uid -u $uid --gid 1000 --no-create-home --quiet
done
