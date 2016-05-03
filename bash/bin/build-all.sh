#!/bin/bash

cd ~/src
echo 'samee-slms:'
cd samee-slms; mvn clean install; cd ..

echo 'samee-slms-rest:'
cd samee-slms-rest; mvn clean install; cd ..

cp ~/src/samee-slms-rest/target/scholastic.slms-rest-web-1.2-SNAPSHOT.war ~/src/samee-environment/jboss-as-7.1.1.Final/scholastic/deployments/

for i in scent-server-core scent2-shared; do cd $i; echo "$i:"; sleep 3; mvn clean install; cd ..; done

echo 'scent-svc-core:'
cd scent-svc-core; mvn clean install -Dgenerated.project.goal=install -P strict; cd ..

# skipping scent-client
for i in tlsp-server-db tlsp-server-chef tlsp-server; do cd $i; echo "$i:"; sleep 3; mvn clean install; cd ..; done


