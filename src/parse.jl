using Match

function strip_comments(program_text::String)
  language_symbols = ['<', '>', '+', '-', '.', ',', '[', ']']
  stripped_text = filter(x -> x in language_symbols, program_text)
end


function safe_pop!(stack)
  try
    return pop!(stack)
  catch e
    return nothing
  end
end

function parse(program_text::String)
  braces = Char[]
  pointer = 0
  code = strip_comments(program_text)

  brace_map = Dict{Int64, Int64}()
  reverse_brace_map = Dict{Int64, Int64}()

  for command in code
    pointer += 1
    @match command begin
      '[' => push!(braces, pointer)
      ']' =>
          begin
            loop_start = safe_pop!(braces)
              if loop_start != nothing
                brace_map[loop_start] = pointer
                reverse_brace_map[pointer] = loop_start
              else
                  println("Braces are unbalanced")
                  return false, nothing, nothing, nothing
              end
            end
    end
  end

  if ~isempty(braces)
    println("Braces are unbalanced")
    return false, nothing, nothing, nothing
  end

  return true, code, brace_map, reverse_brace_map
end
