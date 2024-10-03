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
       dockerA(["@docker build"]) --> publishA(["@dotnet publish"])
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

  publish([deploy])
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


This corresponds to this global build graph:

```mermaid
flowchart LR
classDef forced stroke:red,stroke-width:3px
classDef required stroke:orange,stroke-width:3px
classDef selected stroke:black,stroke-width:3px
942179365051C1A33DCF747C64D41786C8982DD5C9B7EB7D8792D5AB26BC93EE([build src/apps/webapi])
2472A7D7AFE84797E8835F7F8AAA9671A230BC0391CD60D47D68F0982D660F4D([build src/libs/cslib])
942179365051C1A33DCF747C64D41786C8982DD5C9B7EB7D8792D5AB26BC93EE --> 2472A7D7AFE84797E8835F7F8AAA9671A230BC0391CD60D47D68F0982D660F4D
class 942179365051C1A33DCF747C64D41786C8982DD5C9B7EB7D8792D5AB26BC93EE required
class 2472A7D7AFE84797E8835F7F8AAA9671A230BC0391CD60D47D68F0982D660F4D required
6AE17A5B59E873CC19549EC37FF0E70529F5ACF9199EF788A57AA36D515D5305([plan src/deploy])
class 6AE17A5B59E873CC19549EC37FF0E70529F5ACF9199EF788A57AA36D515D5305 required
A4784F53304358C5B2A731D8ADEA338F8DE2217105C7A0B1D76E9CE3536D946F([build src/apps/webapp])
09B7D90F73A18A551759DF0B8F900113268C2015C4B23E930DC1EF5427F55EA4([build src/libs/tslib])
A4784F53304358C5B2A731D8ADEA338F8DE2217105C7A0B1D76E9CE3536D946F --> 09B7D90F73A18A551759DF0B8F900113268C2015C4B23E930DC1EF5427F55EA4
class A4784F53304358C5B2A731D8ADEA338F8DE2217105C7A0B1D76E9CE3536D946F required
class 09B7D90F73A18A551759DF0B8F900113268C2015C4B23E930DC1EF5427F55EA4 required
C84DDA0307CE672A87A67571C61AF0A56E74CC8C6AB291EB1AAF863E0EAE4905([dist src/apps/webapi])
C84DDA0307CE672A87A67571C61AF0A56E74CC8C6AB291EB1AAF863E0EAE4905 --> 942179365051C1A33DCF747C64D41786C8982DD5C9B7EB7D8792D5AB26BC93EE
class C84DDA0307CE672A87A67571C61AF0A56E74CC8C6AB291EB1AAF863E0EAE4905 required
20A918F5A24BDC971D2453B59EB07784463ABFFE026049F1A1BB5C0BE1F06576([deploy src/deploy])
20A918F5A24BDC971D2453B59EB07784463ABFFE026049F1A1BB5C0BE1F06576 --> C84DDA0307CE672A87A67571C61AF0A56E74CC8C6AB291EB1AAF863E0EAE4905
20A918F5A24BDC971D2453B59EB07784463ABFFE026049F1A1BB5C0BE1F06576 --> F7DB4DD0555F1851A6EDF90789A946B7D9385F94186559AC6124CEC556EA1B44
20A918F5A24BDC971D2453B59EB07784463ABFFE026049F1A1BB5C0BE1F06576 --> 6AE17A5B59E873CC19549EC37FF0E70529F5ACF9199EF788A57AA36D515D5305
class 20A918F5A24BDC971D2453B59EB07784463ABFFE026049F1A1BB5C0BE1F06576 required
F7DB4DD0555F1851A6EDF90789A946B7D9385F94186559AC6124CEC556EA1B44([dist src/apps/webapp])
F7DB4DD0555F1851A6EDF90789A946B7D9385F94186559AC6124CEC556EA1B44 --> A4784F53304358C5B2A731D8ADEA338F8DE2217105C7A0B1D76E9CE3536D946F
class F7DB4DD0555F1851A6EDF90789A946B7D9385F94186559AC6124CEC556EA1B44 required
```

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
terrabuild run build
```
This will build applications and create docker images. Note first run needs to download docker images - this can take some time. This will be much faster next time!

You will then have a similar output:
![Build Output](docs/build-output.png)

Docker images are built as well (here in OrbStack) - note tags can differ as this repository evolves:
![Docker Images](docs/docker-images.png)

### Deploy
You can also deploy using Terraform (it's a fake local deployment). You can check deployment in file `src/deploy/deploy.log` and verify it's been updated if something change.
```
terrabuild run deploy
```

Notice that since targets are cached, build is really fast. You will then have a similar output:
![Deploy Output](docs/deploy-output.png)

# Key takeaways
* Building and deploying the project only required few deployment on local machine (Terrabuild and Docker).
* Terrabuild takes care of optimizating build graph where applicable so you don't have to.
* Development environments can be normalized without needing complex local configuration.
* Target executions can be faster when configured to use the global cache.
* Terrabuild can manage both build and deployment requirements.
