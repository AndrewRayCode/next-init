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

npm init

# Packages needed on the host to get types for local typescript tooling
npm install --save --package-lock-only next react react-dom typescript @types/react @types/node
npm install --save-dev prettier

# Add next build scripts
jq '.scripts={"dev": "next -p 3099", "build": "next build", "start": "next start",}' package.json > package.json

# Build the project
docker-compose up build

# Install sass built for the container only
docker-compose exec --rm --no-deps web npm install --save-dev sass

# Do the thing!
docker-compose up