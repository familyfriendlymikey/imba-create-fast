#!/usr/bin/env node

let fs = require('fs-extra')
let path = require('path')
let { execSync } = require('child_process')

let quit = (msg="Quitting.") => {
	console.log(msg)
	process.exit()
}

if (process.argv.length < 3) {
	quit("No project name, quitting.")
}

let template_dir = path.join(__dirname, "base")
let project_dir = path.join(process.cwd(), process.argv[2])

try {
	fs.copySync(template_dir, project_dir)
} catch {
	quit("Failed to copy project template, quitting.")
}

try {
	process.chdir(project_dir)
} catch {
	quit("Failed to change to project dir, quitting.")
}

try {
	execSync('npm i', { stdio: 'inherit' })
} catch {
	quit("Failed to run `npm i`, quitting.")
}


try {
	execSync('npm start', { stdio: 'inherit' })
} catch {
	quit("Failed to run `npm start`, quitting.")
}
