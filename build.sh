#!/bin/sh
set -e

if [ -d "./node_modules" ]; then
  echo "node_modules exists in this folder, can't continue"
  exit 1
fi
if [ -d "./.git" ]; then
  echo ".git exists in this folder, can't continue"
  exit 1
fi

npm init -y

# Packages needed on the host to get types for local typescript tooling
npm install --save --package-lock-only next react react-dom typescript @types/react @types/node
npm install --save-dev prettier

# Add next build scripts
jq '.scripts={"dev": "next -p 3099", "build": "next build", "start": "next start"}' package.json > package.json

# Copy in files from npm install dir to here. We need to use $BASH_SOURCE to
# grab the files relative to the install directory of this package
cp -r "$BASH_SOURCE/template/." ./

# Build the project
docker-compose up build

# Install sass built for the container only
docker-compose exec --rm --no-deps web npm install --save-dev sass

# Do the thing!
docker-compose up
