module COVID19Projections

using DelimitedFiles: writedlm

include("./io.jl")
include("./dynsys/model.jl")

function execute_model(state, params, days)
  print("Building model... ")
  (; print_model, run_model) = DynamicalSystemsModel.gen_model(state, params)
  println("Finished!")
  print_model()
  print("Running model... ")
  results = run_model(days)
  println("Finished!")
  return results
end

function julia_main()::Cint
  (; state, params, output_file, days, start_date) = External.get_args()
  results = execute_model(state, params, days)
  data_output = External.apply_standard_headers(results)
  data_output = External.add_date_column(data_output, start_date, days)
  writedlm(output_file, data_output, ',')
  println("Output saved to `$output_file`")
  return 0
end

end
