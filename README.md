## imba-create-fast

### Installation
```
npm i -g imba-create-fast
```

Creating a shell alias or function is recommended
```
alias cf="imba-create-fast"
```
or
```
cf(){
	imba-create-fast "$1" && \
	cd "$1" && \
	npm i && \
	npm start && \
}
```

### Usage
Create a project in the current directory:
```
imba-create-fast
```

Create a project in directory `project_name`:
```
imba-create-fast project_name
```
