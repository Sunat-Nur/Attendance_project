#!/bin/bash

# ATTENDANCE_PROJECT

# Reset any changes and pull the latest code
git reset --hard
git pull origin master

# Build the project using Maven
mvn clean install