#!/bin/sh
set -e

COLOR_LIGHT_GREEN=$(tput sgr0 && tput bold && tput setaf 2)
COLOR_LIGHT_RED=$(tput sgr0 && tput bold && tput setaf 1)
COLOR_LIGHT_CYAN=$(tput sgr0 && tput bold && tput setaf 6)
COLOR_RESET=$(tput sgr0)

exit_with_error() {
  header "${COLOR_LIGHT_RED}$1${COLOR_RESET}"
  exit 1
}

header() {
  >&2 echo "${COLOR_LIGHT_GREEN}@andrewray/next-init: ${COLOR_LIGHT_CYAN}$1${COLOR_RESET}"
}

if [ ! $(node --version | grep 'v12') ]; then
  exit_with_error 'This script expects Node 12'
fi
if [ -d "./node_modules" ]; then
  exit_with_error "node_modules exists in this folder, can't continue"
fi
if [ -d "./.git" ]; then
  exit_with_error ".git exists in this folder, can't continue"
fi

header 'npm init'
npm init -y

# Packages needed on the host to get types for local typescript tooling
header 'Installing dependencies on host'
npm install --save --package-lock-only next react react-dom typescript @types/react @types/node
npm install --save-dev prettier

# Add next build scripts. jq can't overwrite a file in place, routing it back
# to package.json causes the file to be blank
header 'Adding next scripts to package.json'
jq -r '.scripts={"dev": "next -p 3099", "build": "next build", "start": "next start"}' package.json > a.json && mv a.json package.json

# Copy in files from npm install dir to here. We need to use $BASH_SOURCE to
# grab the files relative to the install directory of this package
header 'Copying in templates'
SOURCE_DIR="`dirname $BASH_SOURCE`/../lib/node_modules/@andrewray/next-init"
cp -r "$SOURCE_DIR/templates/." ./

# Build the project
header 'Building the Docker image'
docker-compose build web

# Install sass built for the container only
header 'Installing sass in the container'
docker-compose run --rm web npm install --save-dev sass

# Do the thing!
header 'Complete! run docker-compose up to get started'
echo "\ndocker-compose up"
