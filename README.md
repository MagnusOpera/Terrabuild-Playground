# Terrabuild Playground Repository
This is a repository where you can quickly try [Terrabuild](https://terrabuild.io). There you will find:
* a .net library project (src/libs/cslib)
* a .net webapi project (src/apps/webapi)
* a typescript (transpiled to js) library (src/libs/tslib)
* a vuejs project (src/apps/webapp)

# Targets
There are several targets declared in this workspace:
* build: just build projects - this is used on developer environment (local build)
* dist: build docker images - this is used on CI but can be used on dev env to check everything is running fine
* push: publish docker images - this is used on CI
