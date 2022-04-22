let path = require 'path'
let { writeFileSync, existsSync, mkdirSync } = require 'fs'
let { execSync } = require 'child_process'

let project_name = process.argv[2]
let outdir = path.resolve(project_name or '')

if existsSync outdir and outdir isnt process.cwd!
	quit "Output path already exists"

template_base!

console.log "Done!"

def quit msg="Error"
	console.log "{msg}, quitting."
	process.exit!

def template_base

	let files = [

		{
			path: '.gitignore'
			data: """
				.DS_Store
				node_modules
				dist
			"""
		}

		{
			path: 'package.json'
			data: """
				\{
					"name": "{project_name}",
					"scripts": \{
						"start": "imba -w server.imba",
						"build": "imba build server.imba"
					\},
					"dependencies": \{
						"express": "^4.17.1",
						"imba": "^2.0.0-alpha.207"
					\}
				\}
			"""
		}

		{
			path: 'server.imba'
			data: """
				import express from 'express'
				import index from './app/index.html'
				const app = express!
				app.get(/.*/) do(req,res)
					unless req.accepts(['image/*', 'html']) == 'html'
						return res.sendStatus(404)
					res.send index.body
				imba.serve app.listen(process.env.PORT or 3000)
			"""
		}

		{
			path: 'app/index.html'
			data: """
				<html lang="en">
						<head>
								<title>{project_name}</title>
								<meta charset="UTF-8">
								<meta name="viewport" content="width=device-width, initial-scale=1">
								<style src='*'></style>
						</head>
						<body>
								<script type="module" src="./client.imba"></script>
						</body>
				</html>
			"""
		}

		{
			path: 'app/client.imba'
			data: """
				tag app
					<self> "hello"
				imba.mount <app>
			"""
		}

	]

	for file in files
		let outpath = path.join outdir, file.path
		mkdirSync path.dirname(outpath), { recursive:yes }
		writeFileSync outpath, file.data
