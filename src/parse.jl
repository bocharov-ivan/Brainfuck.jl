using Match

function strip_comments(program_text::String)
  language_symbols = ['<', '>', '+', '-', '.', ',', '[', ']']
  stripped_text = filter(x -> x in language_symbols, program_text)
end


function safe_pop!(stack)
  try
    pop!(stack)
    return true
  catch e
    return false
  end
end

function check_sanity(program_text::String)
  parentheses = Char[]
  code = strip_comments(program_text)
  for command in code
    @match command begin
      '[' => push!(parentheses, '[')
      ']' => if safe_pop!(parentheses)
              else
                println("Parentheses are unbalanced")
                return false, nothing
              end
    end
  end
  if ~isempty(parentheses)
    println("Parentheses are unbalanced")
    return false, nothing
  end
  return true, code
end

function build_brace_map(code::String)
  pointer = 0
  braces = Int64[]
  brace_map = Dict{Int64, Int64}()
  reverse_brace_map = Dict{Int64, Int64}()

  for command in code
    pointer += 1
    @match command begin
      '[' => push!(braces, pointer)
      ']' =>
            begin
              loop_start = pop!(braces)
              brace_map[loop_start] = pointer
              reverse_brace_map[pointer] = loop_start
            end
    end
  end
  return brace_map, reverse_brace_map
end
