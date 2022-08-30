# Julia Experiment

## Learning the language
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

## The Model

[The paper](https://www.sciencedirect.com/science/article/pii/S0960077921000424)
being used.

