let path = require 'path'
let { writeFileSync, existsSync, mkdirSync } = require 'fs'
let { execSync } = require 'child_process'

def quit msg="Quitting."
	console.log "{msg}, quitting."
	process.exit!

if process.argv.length < 3
	quit "No project name"

let outpath = path.resolve(process.argv[2])
let outpath_is_cwd = outpath === process.cwd!
let outpath_already_exists = existsSync outpath

if outpath_already_exists and !outpath_is_cwd
	quit "Output path already exists"

mkdirSync path.join(outpath, 'app'), { recursive:yes }

template_base!

console.log "Done!"

def template_base
	let data

	data = '''
	.DS_Store
	node_modules
	dist
	'''
	writeFileSync path.join(outpath, '.gitignore'), data

	data = '''
	{
		"name": "app",
		"scripts": {
			"start": "imba -w server.imba",
			"build": "imba build server.imba"
		},
		"dependencies": {
			"express": "^4.17.1",
			"imba": "^2.0.0-alpha.207"
		}
	}
	'''
	writeFileSync path.join(outpath, 'package.json'), data

	data = '''
	import express from 'express'
	import index from './app/index.html'
	const app = express!
	app.get(/.*/) do(req,res)
		unless req.accepts(['image/*', 'html']) == 'html'
			return res.sendStatus(404)
		res.send index.body
	imba.serve app.listen(process.env.PORT or 3000)
	'''
	writeFileSync path.join(outpath, 'server.imba'), data

	data = '''
	<html lang="en">
			<head>
					<title>app</title>
					<meta charset="UTF-8">
					<meta name="viewport" content="width=device-width, initial-scale=1">
					<style src='*'></style>
			</head>
			<body>
					<script type="module" src="./client.imba"></script>
			</body>
	</html>
	'''
	writeFileSync path.join(outpath, 'app', 'index.html'), data

	data = '''
	tag app
		<self> "hello"

	imba.mount <app>
	'''
	writeFileSync path.join(outpath, 'app', 'client.imba'), data
