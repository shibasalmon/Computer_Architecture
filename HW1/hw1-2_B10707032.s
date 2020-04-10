.globl __start

.rodata
    msg0: .string "This is HW1-2: \n"
    msg1: .string "Plaintext:  "
    msg2: .string "Ciphertext: "
.text

################################################################################
  # print_char function
  # Usage: 
  #     1. Store the beginning address in x20
  #     2. Use "j print_char"
  #     The function will print the string stored from x20 
  #     When finish, the whole program with return value 0

print_char:
    addi a0, x0, 4
    la a1, msg2
    ecall
    
    add a1,x0,x20
    ecall

  # Ends the program with status code 0
    addi a0,x0,10
    ecall
    
################################################################################

__start:
  # Prints msg
    addi a0, x0, 4
    la a1, msg0
    ecall
    la a1, msg1
    ecall
    addi a0,x0,8
    lui a1,16
    addi a1,a1,304
    add a3,x0,a1
    addi a2,x0,2047
    ecall
  # Load address of the input string into a0
    add a0,x0,a3

################################################################################ 
  # Write your main function here. 
  # a0 stores the begining Plaintext
  # Do store 66048(0x10200) into x20
    addi x20, x0, 0x102
    slli x20, x20, 8 # let x20 = 66048
    
    add x5, x0, a0 # let x5 = a0 to process the string.
    addi x6, x0, '0' # x6 is for space number.
    
    L1: # the loop is for processing every characters of string. 
      lb x7, 0(x5) # load one character to x7 and it will be processed.
      addi x28, x0, ' ' # load space to x28 and it will be compare with character.
      bne x7, x28, not_space # compare with space.
      sb x6, 0(x20) # if it is, assign the space number to this character.
      addi x6, x6, 1 # x6 += 1
      beq x0, x0, end_L1 # jump to endL1.
      
      not_space:
      addi x28, x0, 'a' # judge that is it a lowercase alphabet
      blt x7, x28, exit_L1
      addi x28, x0, 'z'
      bgt x7, x28, exit_L1
      
      addi x7, x7, 3 # if it is, change the character
      bgt x7, x28, over_z
      addi x7, x7, 26
      
      over_z:
      addi x7, x7, -26
      sb x7, 0(x20) # save the character.
      
      end_L1:
      addi x5, x5, 1 # x5 += 1
      addi x20, x20, 1 # x20 += 1
      beq x0, x0, L1 # jump to L1
    exit_L1:
    
    addi x20, x0, 0x102 # reassign x20 = 66048
    slli x20, x20, 8
    j print_char
  
################################################################################

