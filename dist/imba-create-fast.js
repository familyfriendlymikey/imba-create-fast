#!/usr/bin/env node

/*body*/
let {copySync: copySync,pathExistsSync: pathExistsSync} = require('fs-extra'/*$path$*/);
let path = require('path'/*$path$*/);
let {execSync: execSync} = require('child_process'/*$path$*/);

function quit(msg = "Quitting."){
	
	console.log(("" + msg + ", quitting."));
	return process.exit();
};

if (process.argv.length < 3) {
	
	quit("No project name");
};

let template_path = path.join(__dirname,"template");
let output_path = path.join(process.cwd(),process.argv[2]);

if (pathExistsSync(output_path)) {
	
	quit("Output path already exists");
};

try {
	
	copySync(template_path,output_path);
} catch ($1) {
	
	quit("Failed to copy project template");
};

try {
	
	process.chdir(output_path);
} catch ($2) {
	
	quit("Failed to change to project dir");
};

try {
	
	execSync('npm i',{stdio: 'inherit'});
} catch ($3) {
	
	quit("Failed to run `npm i`");
};

try {
	
	execSync('npm start',{stdio: 'inherit'});
} catch ($4) {
	
	quit("Failed to run `npm start`");
};
