def main()
    print_pairs(5, 500)
    primes = get_prime_array(5, 25)
    #puts primes
    prime_diffs = get_prime_diffs(5, 25)
    #puts prime_diffs
    primemids = get_mid_vals(5, 25)
    #puts primemids
    avgdiff = find_avg_prime_diff(5, 50)
    #puts
    #puts avgdiff.to_s
    min_and_max = find_min_and_max_prime_diff(5, 50)
    puts
    puts min_and_max
end

def consecutivePrimes(begin_val, end_val)

   curr_prime = begin_val
   prime1, prime2 = 1
   while curr_prime <= end_val
    prime1 = find_next_prime(curr_prime)
    prime2 = find_next_prime(prime1 + 1) 

        curr_prime = prime2
        if(curr_prime > end_val)
            break
        end
        if(prime1 >= 1 && prime2 > 1)  # english and/or have lower precedence than symbolic &&/||
            
            yield prime1, prime2
            prime1 = prime2
            prime2 = 1
        end
   end
   
end

def find_next_prime(num)
    while(!is_prime(num))
    num += 1
    end
    num
end

def is_prime(num)
    iterator = 2 
    retVal = true
    # this is very unrubylike
    while((iterator * iterator) <= num)  
        if(num%iterator == 0)
            rem = num%iterator
            retVal = false
            #puts "Iterator is #{iterator}. #{num} mod #{iterator} is #{rem}"
            break
        end
       iterator += 1 

    end
    retVal 
end

def print_pairs(start_val, end_val)
    consecutivePrimes(start_val, end_val) do |prime1, prime2|
        print "[#{prime1} #{prime2}] "
    end
end

def get_prime_array(start_val, end_val)
    prime_array = Array.new
    first = true
    consecutivePrimes(start_val, end_val) do |prime1, prime2|
        
        if(first == false)
            prime_array << prime2
        elsif(first == true)
            prime_array << prime1
            prime_array << prime2
            first = false
        end
    end
    prime_array
end

def get_prime_diffs(start_val, end_val)
    # We could get an array from get_prime_array, however it's more efficient to do the subtractions
    # on pairs as we get them. 
    subtract_array = Array.new
    consecutivePrimes(start_val, end_val) do |prime1, prime2|
        primediff = prime2 - prime1 
        subtract_array << primediff  # Repeating numbers in pairs is ok so no first check
    end
    subtract_array
end

def get_mid_vals(start_val, end_val)
    mid_vals_array = Array.new
    consecutivePrimes(start_val, end_val) do |prime1, prime2|
        primeavg = (prime1.to_f + prime2.to_f)/2.0
        mid_vals_array << primeavg
    end
    mid_vals_array
end

def find_avg_prime_diff(start_val, end_val)
    avgdiff = 0
    divisor = 1 
    consecutivePrimes(start_val, end_val) do |prime1, prime2|
        avgdiff += (prime2 - prime1)
        divisor += 1 
        
    end
    avgdiff /= divisor
    avgdiff
    
end

def find_min_and_max_prime_diff(start_val, end_val)
    minprimediff = 1
    maxprimediff = 1
    init = true
    consecutivePrimes(start_val, end_val) do |prime1, prime2|
        
        thisdiff = prime2-prime1
        if(init == true)
        minprimediff = thisdiff # we need a value to compare to, starting off.
        init = false
        end
        if(thisdiff > maxprimediff)
            maxprimediff = thisdiff
        elsif(thisdiff < minprimediff)
            minprimediff = thisdiff
        end
    end
    return minprimediff, maxprimediff
end

main()

