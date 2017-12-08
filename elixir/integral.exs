defmodule Integral do
    def calculate(coefficients, exponents, start, stop, rslice)
        coex = Enum.zip(coefficients, exponents)
        sums = for n <- coex, do: calculator_helper(n, start, rslice, 0, stop)
        Enum.sum(sums)

    end

    def calculator_helper(coex_item, currslice, rslice, sum, stop)
        cond do
            currslice <= stop ->
                sum = sum + (Kernel.elem(coex_item, 0) * Math.pow(currslice, Kernel.elem(coex_item, 1)))
                calculator_helper(coex_item, currslice + rslice, rslice, sum, stop)
            currslice > stop ->
                sum
        end


    end
end