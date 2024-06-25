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


This corresponds to this global build graph:

```mermaid
flowchart TB
classDef forced stroke:red,stroke-width:3px
classDef required stroke:orange,stroke-width:3px
classDef selected stroke:black,stroke-width:3px
classDef cluster-13F7CAF67B8934899D1AAA883854B159B9E1E49CFDAB389BDD24E4672F57D826 stroke:#8F5,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-32B2BFE44ECA0E2307BAFCE5F3F466E8C19390C1B20F30647D036291110340E1 stroke:#56F,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-99DD49C225ABACFB2E7A0437E146E795DB3A0C4ABD4750C8361C18E326A6C0B4 stroke:#133,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-A9061A612F53DFA1649E99D4F5D0E56F7759BD879DA66EACD70D818CD1C53F11 stroke:#C46,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-CE0B1A748A9F282E240D21940797E39B84941D2CCACD1548C87AE72697E038C9 stroke:#AB4,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-CF0E0D7DD67A58796E6CAFCB42180D0916EA97906676B80801C9B19E6D29020B stroke:#A20,stroke-width:3px,fill:white,rx:10,ry:10
D7DEF1DF9ACC57757F34B1730D482187E47D093CCEE205B5BB5DDD53B747B06B([build src/apps/webapi])
6FE3F4D55B0ED59E4973F54FACA2CFA0536509F25D388CD590FEF38498A209CD([build src/libs/cslib])
D7DEF1DF9ACC57757F34B1730D482187E47D093CCEE205B5BB5DDD53B747B06B --> 6FE3F4D55B0ED59E4973F54FACA2CFA0536509F25D388CD590FEF38498A209CD
class D7DEF1DF9ACC57757F34B1730D482187E47D093CCEE205B5BB5DDD53B747B06B required
class 6FE3F4D55B0ED59E4973F54FACA2CFA0536509F25D388CD590FEF38498A209CD required
1EFE5B7C97917BB6E44E9CA9288769833935631C4F56B56F140FB7F1161A4A7D([plan src/deploy])
class 1EFE5B7C97917BB6E44E9CA9288769833935631C4F56B56F140FB7F1161A4A7D required
922A25A435829F459EA0792B5FEB67BD68ACA1FB3996D4DF2EDB5C78F3697F69([build src/apps/webapp])
DD57A9D24CBA24C6AA3B120942D16D8304847D32272450F9B3F531937D938FD8([build src/libs/tslib])
922A25A435829F459EA0792B5FEB67BD68ACA1FB3996D4DF2EDB5C78F3697F69 --> DD57A9D24CBA24C6AA3B120942D16D8304847D32272450F9B3F531937D938FD8
class 922A25A435829F459EA0792B5FEB67BD68ACA1FB3996D4DF2EDB5C78F3697F69 required
class DD57A9D24CBA24C6AA3B120942D16D8304847D32272450F9B3F531937D938FD8 required
90A975D71E44D90EC45D83E0AAC28C481A53AF6C2AB05F611151F14BD3BF955E([dist src/apps/webapi])
90A975D71E44D90EC45D83E0AAC28C481A53AF6C2AB05F611151F14BD3BF955E --> D7DEF1DF9ACC57757F34B1730D482187E47D093CCEE205B5BB5DDD53B747B06B
class 90A975D71E44D90EC45D83E0AAC28C481A53AF6C2AB05F611151F14BD3BF955E required
3288A15D2D9D4439B74BD499371E2FE725A32CD686B4466126B7464595CE48E1([deploy src/deploy])
3288A15D2D9D4439B74BD499371E2FE725A32CD686B4466126B7464595CE48E1 --> 90A975D71E44D90EC45D83E0AAC28C481A53AF6C2AB05F611151F14BD3BF955E
3288A15D2D9D4439B74BD499371E2FE725A32CD686B4466126B7464595CE48E1 --> 5088113A521173C96529AAF9D9B6EEB6B8C737776C03210C8E1993A80F9DCB2E
3288A15D2D9D4439B74BD499371E2FE725A32CD686B4466126B7464595CE48E1 --> 1EFE5B7C97917BB6E44E9CA9288769833935631C4F56B56F140FB7F1161A4A7D
class 3288A15D2D9D4439B74BD499371E2FE725A32CD686B4466126B7464595CE48E1 required
5088113A521173C96529AAF9D9B6EEB6B8C737776C03210C8E1993A80F9DCB2E([dist src/apps/webapp])
5088113A521173C96529AAF9D9B6EEB6B8C737776C03210C8E1993A80F9DCB2E --> 922A25A435829F459EA0792B5FEB67BD68ACA1FB3996D4DF2EDB5C78F3697F69
class 5088113A521173C96529AAF9D9B6EEB6B8C737776C03210C8E1993A80F9DCB2E required
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

## Batch build

Terrabuild can optimize build when possible. For example, the .net projects in this workspace can be built in one shot:

```mermaid
flowchart TB
classDef forced stroke:red,stroke-width:3px
classDef required stroke:orange,stroke-width:3px
classDef selected stroke:black,stroke-width:3px
classDef cluster-13F7CAF67B8934899D1AAA883854B159B9E1E49CFDAB389BDD24E4672F57D826 stroke:#8F5,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-32B2BFE44ECA0E2307BAFCE5F3F466E8C19390C1B20F30647D036291110340E1 stroke:#56F,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-99DD49C225ABACFB2E7A0437E146E795DB3A0C4ABD4750C8361C18E326A6C0B4 stroke:#133,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-A9061A612F53DFA1649E99D4F5D0E56F7759BD879DA66EACD70D818CD1C53F11 stroke:#C46,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-CE0B1A748A9F282E240D21940797E39B84941D2CCACD1548C87AE72697E038C9 stroke:#AB4,stroke-width:3px,fill:white,rx:10,ry:10
classDef cluster-CF0E0D7DD67A58796E6CAFCB42180D0916EA97906676B80801C9B19E6D29020B stroke:#A20,stroke-width:3px,fill:white,rx:10,ry:10
subgraph 13F7CAF67B8934899D1AAA883854B159B9E1E49CFDAB389BDD24E4672F57D826[batch build]
  D7DEF1DF9ACC57757F34B1730D482187E47D093CCEE205B5BB5DDD53B747B06B([build src/apps/webapi])
  6FE3F4D55B0ED59E4973F54FACA2CFA0536509F25D388CD590FEF38498A209CD([build src/libs/cslib])
end
class 13F7CAF67B8934899D1AAA883854B159B9E1E49CFDAB389BDD24E4672F57D826 cluster-13F7CAF67B8934899D1AAA883854B159B9E1E49CFDAB389BDD24E4672F57D826
D7DEF1DF9ACC57757F34B1730D482187E47D093CCEE205B5BB5DDD53B747B06B --> 6FE3F4D55B0ED59E4973F54FACA2CFA0536509F25D388CD590FEF38498A209CD
class D7DEF1DF9ACC57757F34B1730D482187E47D093CCEE205B5BB5DDD53B747B06B required
class 6FE3F4D55B0ED59E4973F54FACA2CFA0536509F25D388CD590FEF38498A209CD required
5DBF46760980181651E553196A112B7276CC3C9B87D934B9FA5BFF5FF039D1E4([plan src/deploy])
class 5DBF46760980181651E553196A112B7276CC3C9B87D934B9FA5BFF5FF039D1E4 required
922A25A435829F459EA0792B5FEB67BD68ACA1FB3996D4DF2EDB5C78F3697F69([build src/apps/webapp])
DD57A9D24CBA24C6AA3B120942D16D8304847D32272450F9B3F531937D938FD8([build src/libs/tslib])
922A25A435829F459EA0792B5FEB67BD68ACA1FB3996D4DF2EDB5C78F3697F69 --> DD57A9D24CBA24C6AA3B120942D16D8304847D32272450F9B3F531937D938FD8
class 922A25A435829F459EA0792B5FEB67BD68ACA1FB3996D4DF2EDB5C78F3697F69 required
class DD57A9D24CBA24C6AA3B120942D16D8304847D32272450F9B3F531937D938FD8 required
90A975D71E44D90EC45D83E0AAC28C481A53AF6C2AB05F611151F14BD3BF955E([dist src/apps/webapi])
90A975D71E44D90EC45D83E0AAC28C481A53AF6C2AB05F611151F14BD3BF955E --> D7DEF1DF9ACC57757F34B1730D482187E47D093CCEE205B5BB5DDD53B747B06B
class 90A975D71E44D90EC45D83E0AAC28C481A53AF6C2AB05F611151F14BD3BF955E required
9C50ED3D8317AAFE098D11955D84005B9FFAABE468B6A7EC3EAF08227A69F224([deploy src/deploy])
9C50ED3D8317AAFE098D11955D84005B9FFAABE468B6A7EC3EAF08227A69F224 --> 90A975D71E44D90EC45D83E0AAC28C481A53AF6C2AB05F611151F14BD3BF955E
9C50ED3D8317AAFE098D11955D84005B9FFAABE468B6A7EC3EAF08227A69F224 --> 5088113A521173C96529AAF9D9B6EEB6B8C737776C03210C8E1993A80F9DCB2E
9C50ED3D8317AAFE098D11955D84005B9FFAABE468B6A7EC3EAF08227A69F224 --> 5DBF46760980181651E553196A112B7276CC3C9B87D934B9FA5BFF5FF039D1E4
class 9C50ED3D8317AAFE098D11955D84005B9FFAABE468B6A7EC3EAF08227A69F224 required
5088113A521173C96529AAF9D9B6EEB6B8C737776C03210C8E1993A80F9DCB2E([dist src/apps/webapp])
5088113A521173C96529AAF9D9B6EEB6B8C737776C03210C8E1993A80F9DCB2E --> 922A25A435829F459EA0792B5FEB67BD68ACA1FB3996D4DF2EDB5C78F3697F69
class 5088113A521173C96529AAF9D9B6EEB6B8C737776C03210C8E1993A80F9DCB2E required
```

# Key takeaways
* Building and deploying the project only required few deployment on local machine (Terrabuild and Docker).
* Terrabuild takes care of optimizating build graph where applicable so you don't have to.
* Development environments can be normalized without needing complex local configuration.
* Target executions can be faster when configured to use the global cache.
* Terrabuild can manage both build and deployment requirements.
