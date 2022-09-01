# Julia Experiment

## TODOS
- ~~Ensure one step ensures one day.~~ **The parameters are adjusted for about one step being one day.**
- ~~Pass in model parameters and populations using JSONs.~~ **DONE**
- ~~See if InteractiveDynamics could work.~~ This is unnecessary and adds build time + complexity
- Document more important info about the Julia language.
- ~~Append a date column to each entry.~~ **DONE**

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
- **The way I'm referencing the parameters and compartments is flimsy**
  **because it relies on the positional arguments**
- The model maintains the same total population (within an epsilon of 1). The
  error of one person per cell is due to the display showing the floored integer
  version (so the 'error' is in the printing of the cell itself and should not
  carry over).

### Misc.
- [Debug Equations Help](https://discourse.julialang.org/t/psa-how-to-help-yourself-debug-differential-equation-solving-issues/62489)


## Learning the Julia language
The first thing I like to do when learning a new programming language is visit
[Learn X in Y Minutes](https://learnxinyminutes.com/docs/julia/). The link
describes Julia as

> Julia is a new homoiconic functional language focused on technical 
  computing. While having the full power of homoiconic macros, first-class 
  functions, and low-level control, Julia is as easy to learn and use as 
  Python.

The description made sense to me except for the 'homoiconic' bit. According to
the 
[Homoiconicity Wikipedia page:](https://en.wikipedia.org/wiki/Homoiconicity#:~:text=A%20language%20is%20homoiconic%20if,treats%20%22code%20as%20data%22.)
> A language is homoiconic if a program written in it can be manipulated as 
  data using the language, and thus the program's internal representation can 
  be inferred just by reading the program itself. This property is often 
  summarized by saying that the language treats "code as data"

Sounds pretty lispy to me. Here's a 
[Stackoverflow discussion](https://stackoverflow.com/questions/31733766/in-what-sense-are-languages-like-elixir-and-julia-homoiconic)
talking about homoiconicity in Julia (turns out it is a lispy idea).
I'm also using the official 
[Julia documentation](https://docs.julialang.org/en/v1/manual/getting-started/)
to learn this stuff.

### Some Julia notes
- `!` is added at the end of function names to indicate that the function
  modifies state.
- Packages and misc. stuff are on [JuliaHub](https://juliahub.com/ui/Home)
- "Each module introduces a new global scope, separate from the global scope of 
  all other modules—there is no all-encompassing global scope. Modules can 
  introduce variables of other modules into their scope through the using or 
  import statements or through qualified access using the dot-notation, i.e. 
  each module is a so-called namespace as well as a first-class data structure 
  associating names with values," ([source](https://docs.julialang.org/en/v1/manual/variables-and-scoping/)).
- Julia loves to say that functions are first class, but they don't seem more
  powerful than the arrow notation in JS. [Methods](https://docs.julialang.org/en/v1/manual/methods/)
  somewhat extend this by pattern matching by multiple dispatch, but
  it seems kind of clunky.
  - I would really like it if I could define a bunch of anonymous functions
    then concat them into one method.
    - [Doesn't seem like you can :(](https://github.com/JuliaLang/julia/issues/13259)
- Make sure to have Julia Editor support enabled. I'm using
  [Julia-Vim](https://github.com/JuliaEditorSupport/julia-vim)
- Use the Julia package manager by pressing `]` when in the repl
- [How to init a project](https://towardsdatascience.com/how-to-setup-project-environments-in-julia-ec8ae73afe9c)


