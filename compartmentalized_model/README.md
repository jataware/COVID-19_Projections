# Compartmental Model

## The Model

[The paper](https://www.sciencedirect.com/science/article/pii/S0960077921000424)
being used.

### Installing
Run `./build.jl OUTPUT_DIR` to build the project. To then execute, run
`OUTPUT_DIR/bin/COVID19Projections`. Note that compilation takes
about ten minutes.
If that's too slow for you, you can load the project
directly into the REPL and run `julia_main` from `COVID19Projections`.

### Notes on my implementation
- The parameters are scaled poorly so the timestep as a day is a bit off. The model
  implementation is *probably* okay but it hasn't been checked by an expert.
- **The way I'm referencing the parameters and compartments is flimsy**
  **because it relies on the positional arguments**
- The model maintains the same total population (within an epsilon of 1). The
  error of one person per cell is due to the display showing the floored integer
  version (so the 'error' is in the printing of the cell itself and should not
  carry over).
