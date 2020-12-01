#!/bin/bash

echo "--------------------------------------------"
echo "|  Updating dependencies with carthage 😴  |"
echo "--------------------------------------------"

echo "Deleting old dependencies ..."
# Delete old dependencies
rm -rf Carthage/

echo "Updating dependencies ..."
carthage update --platform iOS

echo "--------------------------------------------"
echo "|                 Done ! 😊                 |"
echo "--------------------------------------------"