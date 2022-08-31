module External

using ArgParse: @add_arg_table!, ArgParseSettings, parse_args
using DelimitedFiles: writedlm
using JSON: parse as parse_json 

function save_compartmental_output(output_file, results)
   open(output_file, "w") do io
      writedlm(io,
      [ ["susceptible";] ["early-exposed";] ["pre-symptomatic";] ["symptomatically-infectious";] ["asymptomatically-infectious";] ["quarantined";] ["isolated";] ["recovered";] ["death"] ]
      , ',')
   end
   open(output_file, "a") do io
      writedlm(io, results, ',')
   end
end

function get_args()
  settings = ArgParseSettings()

  @add_arg_table! settings begin
    "--compartments", "-c"
      help = "Path to JSON containing compartment breakdown"
      default = "./configs/population.json"
    "--parameters", "-p"
      help = "Path to JSON containing parameters"
      default = "./configs/params.json"
    "--output", "-o"
      help = "The filehandle to save output"
      default = "./output.csv"
  end

  args = parse_args(settings)
  state = open(parse_json, args["compartments"])
  open(args["parameters"], "r") do io
    params = parse_json(io)
  end
  
  return (;
    state = open(parse_json, args["compartments"]),
    params = open(parse_json, args["parameters"]),
    output_file = args["output"],
  )

end

end
