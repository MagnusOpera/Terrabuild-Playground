
# build projects
target build {
    depends_on = [ target.^build ]
}

# test projects
target test {
    depends_on = [ target.build ]
}

# generate artifacts
target dist {
    depends_on = [ target.build
                   target.^build ]
}

# plan deployment
target plan {
    build = terrabuild.retry ? ~always : ~auto

    depends_on = [ ]
}

# run deployment
target apply {
    depends_on = [ target.plan
                   target.^dist ]
}


locals {
    dotnet = { config: terrabuild.environment ? "Release" : "Debug" }

    runtimes = {
        dotnet: terrabuild.ci ? "linux-x64" : "linux-arm64"
        docker: terrabuild.ci ? ["linux/amd64"] : ["linux/arm64"]
    }

    docker_tags = {
        dotnet_sdk: "9.0" # https://mcr.microsoft.com/artifact/mar/dotnet/sdk/tags
        dotnet_runtime: "9.0" # https://mcr.microsoft.com/artifact/mar/dotnet/runtime/tags
        nodejs: "22.16.0-alpine3.22" # https://hub.docker.com/_/node/tags
        nginx: "1.28.0-alpine" # https://hub.docker.com/_/nginx/tags
    }
}


extension @dotnet {
    image = "mcr.microsoft.com/dotnet/sdk:${local.docker_tags.dotnet_sdk}"
    defaults {
        runtime = local.runtimes.dotnet
        configuration = local.dotnet.config
    }
}

extension @docker {
    defaults {
        platforms = local.runtimes.docker
        image = "ghcr.io/magnusopera/${terrabuild.project}"
    }
}

extension @npm {
    image = "node:${local.docker_tags.nodejs}"
}
