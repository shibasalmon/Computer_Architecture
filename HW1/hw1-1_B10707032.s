.globl __start

.rodata
    msg0: .string "This is HW1-1: T(n)= 4T(n/2)+2n, T(1)=1\n"
    msg1: .string "Enter a number: "
    msg2: .string "The result is: "

.text

################################################################################
  # You may write function here
T:
    addi sp, sp, -8 # prepare to use 8 bytes stack
    sw x1, 4(sp) # push x1 to the stack
    sw x10, 0(sp) # push x10 to the stack
    addi x5, x10, -1 # prepare to compare whether x10 greater than 1
    bgt x5, x0, L1  # compare whether x10 greater than 1
    addi x10, x0, 1 # x10 += 1
    addi sp, sp, 8 # clear stack
    jalr x0, 0(x1) # return
L1:
    srli x10, x10, 1 # n /= 2
    jal x1, T # recursion
    addi x6, x10, 0 # let x6 = x10
    lw x7, 0(sp) # pop to restore x7
    addi x8, x0, 4 # let x8 = 4, prepare to multiply by 4.
    mul x10, x6, x8 # 4*T(n/2)
    add x10, x10, x7 # add n twice
    add x10, x10, x7 # now x10 = 4*T(n/2) + 2n
    lw x1, 4(sp) # restore x1
    addi sp, sp, 8 # clear stack
    jalr x0, 0(x1) #return
################################################################################

__start:
  # Prints msg0
    addi a0, x0, 4
    la a1, msg0
    ecall
  # Prints msg1
    addi a0, x0, 4
    la a1, msg1
    ecall
  # Reads an int
    addi a0, x0, 5
    ecall

################################################################################ 
  # Write your main function here. 
  # Input n is in a0. You should store the result T(n) into t0
  # HW1-1 T(n)= 4T(n/2)+2n, T(1)=1, round down the result of division
    addi t0, a0, 1
    jal x1, T # call T(n) function.
    addi t0, a0, 0 # let t0 = result.
################################################################################

result:
  # Prints msg2
    addi a0, x0, 4
    la a1, msg2
    ecall
  # Prints the result in t0
    addi a0, x0, 1
    add a1, x0, t0
    ecall
  # Ends the program with status code 0
    addi a0, x0, 10
    ecall