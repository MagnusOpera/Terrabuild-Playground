# Terrabuild Playground Repository
This is a repository where you can quickly try [Terrabuild](https://terrabuild.io). There you will find:
* a .net library project (src/libs/cslib)
* a .net webapi project (src/apps/webapi)
* a typescript (transpiled to js) library (src/libs/tslib)
* a vuejs project (src/apps/webapp)

## Targets
There are several targets declared in this workspace:
* build: just build projects - this is used on developer environment (local build)
* dist: build docker images - this is used on CI but can be used on dev env to check everything is running fine
* push: publish docker images - this is used on CI
* plan/deploy: targets to check terraform and deploy. Usually used with gated deployment.

# HOW TO
Before using this repository, please install [Terrabuild](https://terrabuild.io/docs/getting-started/) and [Docker](https://docs.docker.com/desktop/install/mac-install/). If you are running on macOS, it's advised to use [OrbStack](https://docs.orbstack.dev/install).

Then you can clone this repository:
```
git clone https://github.com/MagnusOpera/terrabuild-playground.git
```

Then `cd` into `terrabuild-playground`.

You can then build everything using:
```
terrabuild dist
```
This will build applications and create docker images.
