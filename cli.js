#!/usr/bin/env node
const { spawn } = require('child_process');

const ls = spawn('./build.sh');

ls.stdout.on('data', data => {
    console.log(data.toString());
});

ls.stderr.on('data', data => {
    console.error(data.toString());
});

ls.on('error', (error) => {
    console.error(error.toString());
});
