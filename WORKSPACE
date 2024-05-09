
target build {
  depends_on = [ ^build ]
}

target dist {
  depends_on = [ build ]
}

target push {
  depends_on = [ dist ]
}

target plan {
    depends_on = [ push ]
}

target deploy {
    depends_on = [ plan ]
}

environment default {
  variables = {
    configuration: "Debug"
  }
}

environment release {
  variables = {
    configuration: "Release"
  }
}

extension @dotnet {
  container = "mcr.microsoft.com/dotnet/sdk:8.0"
  defaults = {
    configuration: $configuration
  }
}

extension @npm {
  container = "node:20"
}

extension @terraform {
    container = "hashicorp/terraform:1.8"
}
