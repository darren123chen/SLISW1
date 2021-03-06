fib := method(n,
        if(((n == 1) or (n == 2)), return(1))
        #loop until n == i
        reFib := method(n, i, n1, n2, 
            if((n == i), return(n1 + n2))
                return(reFib(n,(i + 1), n2, (n2 + n1)))
        )
        return(reFib(n, 3, 1, 1))
    )

fib(1) println
fib(2) println
fib(10) println
