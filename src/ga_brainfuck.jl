include("run.jl")

function hammingDistance(first::ASCIIString, second::ASCIIString)
    if length(first) > length(second)
        first, second = second, first
    end
    distance = 0
    for pointer in collect(1:length(first))
        if first[pointer] != second[pointer]
            distance += 1
        end
    end
    distance += length(second) - length(first)
    return distance
end

module brainfuckga

type BrainfuckProgram <: Entity
    code::ASCIIString
    fitness

    BrainfuckProgram() = new("", nothing)
    BrainfuckProgram(code) = new(code, nothing)
end

function create_entity(num)
    
end

function fitness(ent)
    result = run(ent.code)
    return hammingDistance(result, "Hello, master!")
end

function isless(lhs::BrainfuckProgram, rhs::BrainfuckProgram)
    abs(lhs.fitness) > abs(rhs.fitness)
end


function group_entities(pop)
    if pop[1].fitness == 0
        return
    end

    for i in 1:length(pop)
        produce([1, i])
    end
end

function crossover(group)
    child = BrainfuckProgram()

    # grab each element from a random parent
    num_parents = length(group)
    #for i in 1:length(group[1].abcde)
    #    parent = (rand(Uint) % num_parents) + 1
        #child.abcde[i] = group[parent].abcde[i]
    #end

end

function mutate(ent)
    #mutation rate
    rand(Float64) < 0.8 && return
end


end

