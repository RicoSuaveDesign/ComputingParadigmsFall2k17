alias :math, as: Math
defmodule Integralcalc do

    def calculate(coefficients, exponents, start, stop, rslice) do
        coex = Enum.zip(coefficients, exponents)
        sums = for n <- coex, do: calculator_helper(n, start, rslice, 0, stop)
        (Enum.sum(sums))/10

    end

    def calculator_helper(coex_item, currslice, rslice, sum, stop) do
       # IO.puts currslice
        cond do
            currslice <= stop ->
                sum = sum + (Kernel.elem(coex_item, 0) * Math.pow(currslice, Kernel.elem(coex_item, 1)))
                calculator_helper(coex_item, currslice + rslice, rslice, sum, stop)
            currslice > stop ->
                sum
        end


    end  

end

co = [2, 3]
ex = [2, 1]
IO.puts Integralcalc.calculate(co, ex, 1, 2, 0.1)