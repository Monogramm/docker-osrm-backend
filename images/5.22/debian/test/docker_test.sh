#!/bin/sh

set -e

echo "Waiting to ensure everything is fully ready for the tests..."
sleep 60

echo "Checking main containers are reachable..."
if ! ping -c 10 -q osrm-backend ; then
    echo 'OSRM Backend Main container is not responding!'
    # TODO Display logs to help bug fixing
    #echo 'Check the following logs for details:'
    #tail -n 100 logs/*.log
    exit 2
fi

#if ! ping -c 10 -q osrm-backend-db ; then
#    echo 'OSRM Backend Database container is not responding!'
#    # TODO Display logs to help bug fixing
#    #echo 'Check the following logs for details:'
#    #tail -n 100 logs/*.log
#    exit 4
#fi

# https://docs.docker.com/docker-hub/builds/automated-testing/
echo "Executing OSRM Backend test request..."
curl "http://osrm-backend:5000/route/v1/driving/13.388860,52.517037;13.385983,52.496891?steps=true"

# Success
echo 'Docker tests successful'
exit 0
