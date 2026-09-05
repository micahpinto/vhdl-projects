# 8-Bit Multiplier

A VHDL implementation of an 8-bit multiplier using shift-and-add FSM algorithm on the Arty S7-25 FPGA board.

## What This Project Does

Takes two 8-bit numbers and multiplies them to produce a 16-bit result.

**Example:**
```
A = 00000111 (7 in decimal)
B = 00001111 (15 in decimal)
Result = 0000000001101001 (105 in decimal)
```
## How It Works

The multiplier uses a **shift-and-add algorithm** with a state machine:

1. Load A and B values
2. For each of the 8 bits in B:
   - Check if B's current bit is 1
   - If yes, add A to the running sum
   - Shift A left (multiply by 2)
   - Shift B right (move to next bit)
3. Return the result

**Example for 7 × 15:**
```
Iteration 1: B's bit 0 = 1, add 7 → sum = 7, shift A to 14
Iteration 2: B's bit 1 = 1, add 14 → sum = 21, shift A to 28
Iteration 3: B's bit 2 = 1, add 28 → sum = 49, shift A to 56
Iteration 4: B's bit 3 = 1, add 56 → sum = 105, shift A to 112
Iterations 5-8: B's remaining bits are 0, don't add
Result = 105
```

## The State Machine

The multiplier uses 6 states to control the multiplication:

- **IDLE**: Waiting for start signal
- **LOAD**: Load A and B, clear sum, reset counter
- **ADD**: Check if B's current bit is 1, if yes add A to sum
- **SHIFT**: Shift A left and B right (move to next bit)
- **COMPARE**: Have we done all 8 bits? If no, go back to ADD
- **FINISH**: Result ready, hold until start goes low

Each state takes 1 clock cycle.

## Inputs and Outputs

**Inputs:**
- `clk` - 100 MHz clock
- `rst` - Reset (active high)
- `A` - First 8-bit number (0-255)
- `B` - Second 8-bit number (0-255)
- `start` - Pulse to begin multiplication

**Outputs:**
- `result` - 16-bit result (0-65,025)
- `en` - Enable/Ready signal (goes HIGH when result is ready)

## Test Cases

The testbench includes the main test case:

- **7 × 15 = 105** 

This can be modified to test other values:
- 5 × 3 = 15
- 10 × 10 = 100
- 255 × 255 = 65,025
- 0 × 255 = 0

