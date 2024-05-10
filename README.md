<a href="https://terrabuild.io?utm_campaign=magnusopera-terrabuild-playground-github-repo&utm_source=github.com&utm_medium=top-logo" title="Terrabuild - Monorepo build tool">
    <img src="https://terrabuild.io/images/logo-name.svg" height="50" />
</a>

# Terrabuild Playground Repository
This is a repository where you can quickly try [Terrabuild](https://terrabuild.io). There you will find:
* a .net library project (src/libs/cslib)
* a .net webapi project (src/apps/webapi)
* a typescript (transpiled to js) library (src/libs/tslib)
* a vuejs project (src/apps/webapp)

### Dependencies
* Project `src/apps/webapi` has a dependency on `src/libs/cslib`
* Project `src/apps/webapp` has a dependency on `src/libs/tslib`
* Project `src/deploy` has dependencies on `src/apps/webapi` and `src/apps/webapp`

```mermaid
flowchart LR
  classDef default fill:moccasin,stroke:black
  classDef project fill:gainsboro,stroke:black,rx:10,ry:10
  classDef build fill:palegreen,stroke:black,rx:20,ry:20
  classDef publish fill:skyblue,stroke:black,rx:20,ry:20
  classDef target fill:white,stroke-width:2px,stroke-dasharray: 5 2

  subgraph A[".net WebApi"]
    subgraph targetBuildA["target build"]
      direction LR
      buildA(["@dotnet build"])
    end

    subgraph targetBuildA["target build"]
      direction LR
      buildA(["@dotnet build"])
    end

    subgraph targetPublishA["target dist"]
      direction LR
      publishA(["@dotnet publish"]) --> dockerA(["@docker build"])
    end

    class targetBuildA build
    class targetPublishA publish
  end

  subgraph B["Vue.js WebApp"]
    subgraph targetBuildB["target build"]
      direction LR
      publishB(["@npm build"])
    end

    subgraph targetPublishB["target dist"]
      direction LR
      dockerB(["@docker build"])
    end

    class targetBuildB build
    class targetPublishB publish
  end

  subgraph C[".net Library"]
    subgraph targetBuildC["target build"]
      direction LR
      buildC(["@dotnet build"])
    end

    class targetBuildC build
  end

  subgraph D["Typescript Library"]
    subgraph targetBuildD["target build"]
      direction LR
      buildD(["@npm build"])
    end

    class targetBuildD build
  end

  publish([dist])
  targetBuildB --> targetBuildD
  targetBuildA --> targetBuildC
  targetPublishA --> targetBuildA
  publish -.-> targetPublishA
  
  targetPublishB --> targetBuildB
  publish -.-> targetPublishB

  class A,B,C,D project
  class publish target
```

### Targets
There are several targets declared in this workspace:
* build: just build projects - this is used on developer environment (local build)
* dist: build and publish docker images - this is used on CI but can be used on dev env to check everything is running fine (images stay local if not building on CI)
* plan/deploy: targets to check terraform and deploy. Used in gated deployment on CI.

# HOW TO
Before using this repository, please install [Terrabuild](https://terrabuild.io/docs/getting-started/) and [Docker](https://docs.docker.com/desktop/install/mac-install/). If you are running on macOS, you are advised to use [OrbStack](https://docs.orbstack.dev/install) as it is much faster than Docker Desktop.

Then you can clone this repository:
```
git clone https://github.com/MagnusOpera/terrabuild-playground.git
cd terrabuild-playground
```

### Build
You can then build everything using:
```
terrabuild build
```
This will build applications and create docker images. Note first run needs to download docker images - this can take some time. This will be much faster next time!

You will then have a similar output:
![Build Output](docs/build-output.png)

Docker images are built as well (here in OrbStack) - note tags can differ as this repository evolves:
![Docker Images](docs/docker-images.png)

### Deploy
You can also deploy using Terraform (it's a fake local deployment).
```
terrabuild deploy
```

Notice that since targets are cached, build is really fast. You will then have a similar output:
![Deploy Output](docs/deploy-output.png)

# Key takeaways
* Building and deploying the project only required few deployment on local machine (Terrabuild and Docker).
* Development environments can be normalized without needing complex local configuration.
* Target executions can be faster when configured to use the global cache.
* Terrabuild can manage both build and deployment requirements.
