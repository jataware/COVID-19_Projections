module External

using ArgParse: @add_arg_table!, ArgParseSettings, parse_args
using Dates: Date, Day, today
using JSON: parse as parse_json 

function add_date_column(data_output, start_date, days)
   date_column = vcat(["date"], [Date(start_date) + Day(i - 1) for i in 1:days])
   return hcat(date_column, data_output)
end

function apply_standard_headers(results)
  headers = ["susceptible", "early-exposed", "pre-symptomatic", 
             "symptomatically-infectious", "asymptomatically-infectious", 
             "quarantined", "isolated", "recovered", "death" 
            ]
  return vcat(permutedims(headers), results)
end

function get_args()
  settings = ArgParseSettings()

  @add_arg_table! settings begin
    "--compartments", "-c"
      help = "Path to JSON containing compartment breakdown"
      default = "./configs/population.json"
    "--days", "-d"
      help = "The amount of days to run the model for"
      arg_type = Int
      default = 365
    "--output", "-o"
      help = "The filehandle to save output"
      default = "./output.csv"
    "--parameters", "-p"
      help = "Path to JSON containing parameters"
      default = "./configs/params.json"
    "--startdate", "-s"
      help = "The start date for the model"
      default = string(today())
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
    days = args["days"],
    start_date = args["startdate"]
  )

end

end
