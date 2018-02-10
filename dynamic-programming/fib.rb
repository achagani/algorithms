# The purpose of the following script to make comparisions between using a 
# recursive approach vs memoization for the fib method

# Summary
# Naive Fib: O(2^n)
# Memoized Fib: O(n)


# Greedy Recursive
def fib(n)
    return 0 if n == 0
    return 1 if n == 1

    return fib(n-1) + fib(n-2)
end

# puts fib(35) #~2.8s O(2^n)




# Memoization 
def _fib_dynamic(n, fibs)
    return 0 if n == 0
    return 1 if n == 1


    # puts "BEFORE: N(#{n}: #{fibs}"

    if fibs[n-1].nil?
        # puts "calculating n1 for (#{n})"
        fibs[n-1] = _fib_dynamic(n-1, fibs)
    end

    if fibs[n-2].nil?
        # puts "calculating n2 for (#{n})"
        fibs[n-2] = _fib_dynamic(n-2, fibs)
    end

    # puts "AFTER: N(#{n}: #{fibs}"
    return fibs[n-1] + fibs[n-2]
end

def fib_dynamic(n)
    fibs = Hash.new
    return _fib_dynamic(n, fibs)
end
puts fib_dynamic(1000) # 0.5s O(N)
