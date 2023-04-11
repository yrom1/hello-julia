using Base.Threads

# The memset_kernel function sets all elements of the input array to a specified value.
# It uses multi-threading to process the array in parallel.
function memset_kernel(array, value)
    # The @threads macro divides the for loop iterations among available CPU threads.
    # Each thread will process a portion of the array independently and in parallel.
    @threads for i in 1:length(array)
        # The @inbounds macro disables array bounds checking for this operation,
        # which can improve performance but may lead to undefined behavior if the index is out of bounds.
        @inbounds array[i] = value
    end
    return
end

# The main function creates an array, sets all its elements to a specified value, and verifies the result.
function main()
    # Create an uninitialized array of Float32 elements with a length of 512.
    a = Array{Float32}(undef, 512)

    # Call the memset_kernel function to set all elements of the array to the value 42.
    memset_kernel(a, 42)

    # Verify that all elements of the array have been set to the value 42.
    # The @assert macro checks the condition and raises an error if it is false.
    @assert all(isequal(42), a)

    # Print a message to indicate that the array has been successfully set to the specified value.
    println("Array is successfully set to value 42")
end

# Call the main function to execute the code.
main()

#=
(main) Ryans-MacBook-Air:hello-julia ryan$ julia threads.jl
Array is successfully set to value 42
=#
