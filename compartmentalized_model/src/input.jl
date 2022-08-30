module Input

using DynamicalSystems: SVector

const state = SVector(NTuple((;
  # Integration does not ensure that these values will remain integers. 
  susceptible = 990000000.0,
  exposed = 18000000.0,
  presymptomatic = 4000000.0,
  symptomatic_infected = 10448134.0,
  asymptomatic_infected = 2000000.0,
  quarantined = 1000000.0,
  isolated = 1000000.0,
  recovered = 9000000.0,
  death = 151000.0,
)))

const total_population = sum(state);

const parameters = SVector(NTuple((;
    βI = 0.550,
    βA = 0.300, 
    βQ = 0.500, 
    βL = 0.300, 
    βE₂ = 0.300, 
    m = 0.100, 
    ζ = 0.500, 
    κ₁ = 0.250, 
    κ₂ = 1.000, 
    ρ = 0.650, 
    q = 0.300,
    τI = 0.100, 
    τA = 0.100, 
    γI = 0.143, 
    γA = 0.143, 
    γQ = 0.048, 
    γL = 0.048,
    δI = 0.001, 
    δL = 0.001, 
    δQ = 0.001, 
    total_population = total_population
)))

end
