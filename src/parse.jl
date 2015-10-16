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
