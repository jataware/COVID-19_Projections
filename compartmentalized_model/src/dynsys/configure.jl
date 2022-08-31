module Configure

using DynamicalSystems: SVector, Dataset

coerce_int = (dataset) -> Dataset(
  [map(x->Int64(floor(x)),row) for row in eachrow(dataset)]
)

function reformat_state(state) :: SVector{9, Float64}
  return SVector{9, Float64}(
    state["susceptible"],
    state["exposed"],
    state["presymptomatic"],
    state["symptomatic_infected"],
    state["asymptomatic_infected"],
    state["quarantined"],
    state["isolated"],
    state["recovered"],
    state["death"],
  )

end

function reformat_params(params) :: SVector{20, Float64}
  return SVector{20, Float64}(
    params["βI"],
    params["βA"],
    params["βQ"],
    params["βL"], 
    params["βE₂"], 
    params["m"],
    params["ζ"],
    params["κ₁"], 
    params["κ₂"], 
    params["ρ"],
    params["q"],
    params["τI"],
    params["τA"],
    params["γI"],
    params["γA"],
    params["γQ"],
    params["γL"],
    params["δI"],
    params["δL"],
    params["δQ"],
  )

end

end


