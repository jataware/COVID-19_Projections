module Input

using DynamicalSystems: SVector

const state = SVector(NTuple((;
  susceptible = 990000000,
  exposed = 18000000,
  presymptomatic = 4000000,
  symptomatic_infected = 10448134,
  asymptomatic_infected = 2000000,
  quarantined = 1000000,
  isolated = 1000000,
  recovered = 9000000,
  death = 151000,
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
