
# require all dependencies to be built before building this target
target build {
  depends_on = [ ^build ]
}

# requires project to be built before proceeding
target dist {
  depends_on = [ build ]
}

target plan {
    depends_on = [ dist ]
}

target deploy {
    depends_on = [ plan ]
}

# default variables for targets
configuration {
  variables = {
    configuration: "Debug"
  }
}

configuration release {
  variables = {
    configuration: "Release"
  }
}

# .net sdk version is forced and build is happening in a container
# no need to install .net sdk on developer machines
# also the environment defines the target configuration
extension @dotnet {
  container = "mcr.microsoft.com/dotnet/sdk:8.0"
  defaults = {
    configuration: $configuration
  }
}

# nodejs version is forced and build is happening in a container
# no need to install nodejs on developer machines
extension @npm {
  container = "node:20"
}

# terraform version is forced and build is happening in a container
# no need to install terraform on developer machines
extension @terraform {
    container = "hashicorp/terraform:1.8"
}
