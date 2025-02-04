const indent = 4

mutable struct Logger
    level::Int
    verbose::Bool
    Logger(verbose) = new(0, verbose)
end

function print_message(l::Logger, msg, eq::AbstractArray; color=:green)
    if !l.verbose return end
    print(repeat(" ", l.level * indent))
    print(msg, ": ")

    printstyled("{"; color=:red)
    for i = 1:length(eq)-1
        printstyled(eq[i]; color)
        printstyled(", "; color=:red)
    end
    printstyled(eq[end]; color)
    printstyled("}\n"; color=:red)
end

function print_message(l::Logger, msg, eq; color=:red)
    if !l.verbose return end
    print(repeat(" ", l.level * indent))
    print(msg, ": ")
    printstyled(eq, '\n'; color)
end

function print_message(l::Logger, msg)
    if !l.verbose return end
    print(repeat(" ", l.level * indent))
    print(msg, '\n')
end

function print_message(l::Logger, msg, solved, unsolved; color1=:green, color2=:red)
    if !l.verbose return end
    print(repeat(" ", l.level * indent))
    print(msg, ": ")
    printstyled(solved; color=color1)
    if !isequal(unsolved, 0)
        print(" + ")
        printstyled("∫ ", unsolved; color=color2)
    end
    println()
end

##############################################################################

function attempt(l::Logger, msg, eq)
    print_message(l, msg, eq)
    l.level += 1
end

function attempt(l::Logger, msg)
    print_message(l, msg)
    l.level += 1
end

function inform(l::Logger, msg, eq)
    print_message(l, msg, eq)
end

function inform(l::Logger, msg)
    print_message(l, msg)
end

function result(l::Logger, msg, eq)
    if l.level > 0 l.level -= 1 end
    print_message(l, msg, eq)
end

function result(l::Logger, msg)
    if l.level > 0 l.level -= 1 end
    print_message(l, msg)
end

function result(l::Logger)
    if l.level > 0 l.level -= 1 end
end

function result(l::Logger, msg, solved, unsolved)
    if l.level > 0 l.level -= 1 end
    print_message(l, msg, solved, unsolved)
end
