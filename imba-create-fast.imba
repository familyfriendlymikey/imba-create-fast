let { copySync, pathExistsSync } = require 'fs-extra'
let path = require 'path'
let { execSync } = require 'child_process'

def quit msg="Quitting."
	console.log "{msg}, quitting."
	process.exit!

if process.argv.length < 3
	quit "No project name"

let template_path = path.join __dirname, "template"
let output_path = path.join process.cwd!, process.argv[2]

if pathExistsSync output_path
	quit "Output path already exists"

try
	copySync template_path, output_path
catch
	quit "Failed to copy project template"

try
	process.chdir output_path
catch
	quit "Failed to change to project dir"

try
	execSync 'npm i', { stdio: 'inherit' }
catch
	quit "Failed to run `npm i`"

try
	execSync 'npm start', { stdio: 'inherit' }
catch
	quit "Failed to run `npm start`"
