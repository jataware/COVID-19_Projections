module COVID19Projections

using Printf: @printf
using DynamicalSystems: ContinuousDynamicalSystem, SVector

include("./input.jl")

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

  return SVector(
    (λE₂ + λA + λI + λQ + λL) * S,
    (λE₂ + λA + λI + λQ + λL)*S - κ₁*E₁,
    κ₁*E₁ - (κ₂ + q)*E₂,
    κ₁*E₁ - (κ₂ + q)*E₂,
    ρ*κ₂*E₂ − (τI + γI + δI)*I,
    (1 − ρ)*κ₂*E₂ − (τA + γA)*A,
    q*E₂ − (γQ + δQ)*Q,
    τI*I + τA*A − (δL + γL)*L,
    γI*I + γA*A + γQ*Q + γL*L,
    δI*I + δL*L + δQ*Q
  )
end

function julia_main()::Cint
  system = ContinuousDynamicalSystem(
    nabi_kumar_erturk,
    Input.state,
    Input.parameters
  )
  @printf """
   The Nabi-Kumar-Erturk System has been loaded:

   %s

   """ system
  return 0
end

end
