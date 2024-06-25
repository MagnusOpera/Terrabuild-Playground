
# build projects
target build {
    depends_on = [ ^build ]
}

# generate artifacts
target dist {
    depends_on = [ build ^dist ]
}

# plan deployment
target plan {
    depends_on = [ ^plan ]
}

# run deployment
target deploy {
    depends_on = [ plan ^apply ^dist ] 
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
