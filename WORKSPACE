
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
  defaults = {
    configuration: $configuration
  }
}
