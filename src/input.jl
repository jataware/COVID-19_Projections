module Input

using DynamicalSystems: SVector

const state = SVector(NTuple((;
  susceptible = 0,
  exposed = 0,
  presymptomatic = 0,
  symptomatic_infected = 0,
  asymptomatic_infected = 0,
  quarantined = 0,
  isolated = 0,
  recovered = 0,
  death = 0,
)))

const total_population = sum(state);

const parameters = SVector(NTuple((;
    βI=0,
    βA=0, 
    βQ=0, 
    βL=0, 
    βE₂=0, 
    m=0, 
    ζ=0, 
    κ₁=0, 
    ρκ₂=0, 
    ρ=0, 
    q=0,
    τI=0, 
    τA=0, 
    γI=0, 
    γA=0, 
    γQ=0, 
    γL=0,
    δI=0, 
    δL=0, 
    δQ=0, 
    total_population = total_population
)))

const total = sum(state);



end
