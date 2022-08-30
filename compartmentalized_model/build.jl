#!/usr/bin/env julia

if length(ARGS) == 0
    println("Error: Pass in name of directory to be created.")
    exit()
end

println("Starting installation")
import Pkg
Pkg.activate(dirname(PROGRAM_FILE))
Pkg.instantiate()

println("Building model")
println("(warning: this may take a few minutes)")
import PackageCompiler
PackageCompiler.create_app(dirname(PROGRAM_FILE),ARGS[1])

println("Model finished:")
println("Run by using `$(ARGS[1])/bin/COVID19Projections`")
