module DynamicalSystemsModel

using Printf: @printf
using DynamicalSystems: ContinuousDynamicalSystem, Dataset, SVector, trajectory

include("./configure.jl")

function gen_nabi_kumar_erturk(initial_state)
  #TODO: Perhaps precalc entire gen_λ func? Only issue with that is we won't
  #... be able to have m and ζ as parameters
  total_population = sum(initial_state)
  @inbounds function nabi_kumar_erturk(state, p, t)
    ( S, E₁, E₂, I, A, Q, L, R, D ) = state
    (
      βI, βA, βQ, βL, βE₂, 
      m, ζ, κ₁, κ₂, ρ, q,
      τI, τA, γI, γA, γQ, γL,
      δI, δL, δQ
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
  return nabi_kumar_erturk
end

function gen_model(state, params)
  formatted_state = Configure.reformat_state(state)
  formatted_params = Configure.reformat_params(params)
  system = ContinuousDynamicalSystem(
    gen_nabi_kumar_erturk(formatted_state),
    formatted_state,
    formatted_params
  )

  function print_model()
    @printf """
     The Nabi-Kumar-Erturk System has been loaded:
     %s
     """ system 
  end

  function run_model(days)
    steps = trajectory(system, days-1, Δt = 1)
    return Configure.coerce_int(steps)
  end

  return (; 
    print_model,
    run_model
  )

end


end
