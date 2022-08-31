module COVID19Projections

include("./io.jl")
include("./dynsys/model.jl")

function execute_model(state, params)
  print("Building model... ")
  (;print_model, run_model) = DynamicalSystemsModel.gen_model(state, params)
  println("Finished!")
  print_model()
  print("Running model... ")
  results = run_model(364)
  println("Finished!")
  return results
end

function julia_main()::Cint
  (;state, params, output_file) = External.get_args()
  results = execute_model(state, params)
  External.save_compartmental_output(output_file, results); println("Output saved to `$output_file`")
  return 0
end

end
