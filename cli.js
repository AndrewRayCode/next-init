#!/usr/bin/env node
const { spawn } = require('child_process');
const path = require('path');

const ls = spawn(path.resolve(__dirname, './build.sh'));

ls.stdout.on('data', data => {
    console.log(data.toString());
});

ls.stderr.on('data', data => {
    console.error(data.toString());
});

ls.on('error', (error) => {
    console.error('Error running build script!');
    console.error(error.toString());
    process.exit(1);
});
