module COVID19Projections

using Printf: @printf
using DelimitedFiles: writedlm
using DynamicalSystems: ContinuousDynamicalSystem, Dataset, SVector, trajectory

include("./input.jl")

coerce_int = (dataset) -> Dataset(
  [map(x->Int64(floor(x)),row) for row in eachrow(dataset)]
)


@inline @inbounds function nabi_kumar_erturk(state, p, t)
  ( S, E₁, E₂, I, A, Q, L, R, D ) = state
  (
    βI, βA, βQ, βL, βE₂, 
    m, ζ, κ₁, κ₂, ρ, q,
    τI, τA, γI, γA, γQ, γL,
    δI, δL, δQ, total_population
  ) = p
  gen_λ = (βₓ, compartment) -> ( coefficient = βₓ * (1 - m*ζ); 
                                 ratio = compartment/total_population;
                                 coefficient * ratio;
                               )
  λE₂ = gen_λ(βE₂, E₂)
  λA = gen_λ(βA, A)
  λI = gen_λ(βI, I)
  λQ = gen_λ(βQ, Q)
  λL = gen_λ(βL, L)

  return SVector(NTuple((;
    S = -(λE₂ + λA + λI + λQ + λL) * S,
    E₁ = (λE₂ + λA + λI + λQ + λL)*S - κ₁*E₁,
    E₂ = κ₁*E₁ - (κ₂ + q)*E₂,
    I = ρ*κ₂*E₂ − (τI + γI + δI)*I,
    A = (1 − ρ)*κ₂*E₂ − (τA + γA)*A,
    Q = q*E₂ − (γQ + δQ)*Q,
    L = τI*I + τA*A − (δL + γL)*L,
    R = γI*I + γA*A + γQ*Q + γL*L,
    D = δI*I + δL*L + δQ*Q
  )))
end

function julia_main()::Cint
  system = ContinuousDynamicalSystem(
    nabi_kumar_erturk,
    Input.state,
    Input.parameters
  )

  results = coerce_int(trajectory(system, 365, Δt = 1))
  @printf """
   The Nabi-Kumar-Erturk System has been loaded:

   %s

   """ system 
   writedlm("output.txt", results, ',')
  return 0
end

end
