using Match

function pointer_inc!(pointer, tape)
  pointer += 1
  if pointer > length(tape)
    push!(tape, 'a')
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

function run(program_text::String)
  tape = Char[]
  pointer = 0

  for command in program_text
    @match command begin
      '>' => pointer, tape = pointer_inc!(pointer, tape)
      '<' => pointer = pointer_dec!(pointer)
      '+' => tape[pointer] += 1
      '-' => tape[pointer] -= 1
      '.' => print(tape[pointer])
      ',' => tape[pointer]=read(STDIN,Char)
    end
    println(pointer, tape)
  end
  return tape
end

println(run(">>>>++++++,."))
