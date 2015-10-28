using Match
include("parse.jl")
export run

function pointer_inc!(pointer, tape)
  pointer += 1
  if pointer > length(tape)
    push!(tape, 0)
  end
  pointer, tape
end

function pointer_dec!(pointer)
  pointer -= 1
  if pointer < 1
      pointer = 1
  end
  pointer
end

function execute(program_text::AbstractString, brace_map::Dict{Int64, Int64},
  reverse_brace_map::Dict{Int64, Int64})

  tape = Char[]
  push!(tape, 0)
  pointer = 1
  command_pointer = 1

  while command_pointer <= length(program_text)
    command = program_text[command_pointer]
    @match command begin
      '>' => pointer, tape = pointer_inc!(pointer, tape)
      '<' => pointer = pointer_dec!(pointer)
      '+' => tape[pointer] += 1
      '-' => tape[pointer] -= 1
      '.' => print(tape[pointer])
      ',' => tape[pointer]=read(STDIN,Char)
      '[' =>
          if tape[pointer] == 0
            command_pointer = brace_map[command_pointer]
          end
      ']' =>
          if tape[pointer] > 0
            command_pointer = reverse_brace_map[command_pointer]
          end
    end
    command_pointer += 1
  end
  return tape
end

function run(program_text::ASCIIString)
    brace_map, reverse_brace_map = build_brace_map(program_text)
    execute(program_text, brace_map, reverse_brace_map)
end

code = "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
run(code)
