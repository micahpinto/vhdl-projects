# Multiplexed 7-Segment Display Controller

A VHDL implementation of a multiplexed display controller for the Arty S7-25 FPGA development board. This project demonstrates how to drive four 7-segment displays using the multiplexing technique, allowing multiple displays to share the same decoder while appearing to light up simultaneously.

This project implements a **4-digit multiplexed display system** on an FPGA. Instead of using four separate BCD decoders and complex wiring, **multiplexing allows a single decoder to service all four displays sequentially at high speed (1 kHz)**.

## Expected Output

A 4-digit number (e.g., **1234**) on four 7-segment displays, with optional decimal points on each digit.

Note-Instead of displaying all four digits simultaneously, the system rapidly cycles through each display:
```
Time 0-1ms: Display 0 ON (shows digit 0)
Time 1-2ms: Display 1 ON (shows digit 1)
Time 2-3ms: Display 2 ON (shows digit 2)
Time 3-4ms: Display 3 ON (shows digit 3)
Time 4-5ms: Display 0 ON (repeat cycle)
```
This cycles 1000 times per second (1 kHz), so one's eyes blend the 4 images together and see "1234" on all 4 displays at the same time.

## Why Multiplexing?

Instead of needing 4 separate BCD decoders (expensive and complex), we use 1 decoder and quickly switch between displays. This saves hardware, wiring, and power.

## The Modules

### CLOCK_DIVIDER.vhd

Slows down the 100 MHz clock to something usable. It counts to 50 (or 5 in simulation) and toggles an output, creating a slower clock for the rest of the system.

### AN_GENERATOR.vhd

Counts 0 → 1 → 2 → 3 → 0 (cycles through the 4 displays). Each time it counts, it outputs which display should be active:

- Counter 0: Turn on Display 0
- Counter 1: Turn on Display 1
- Counter 2: Turn on Display 2
- Counter 3: Turn on Display 3

### DATA_CONTROLLER.vhd

A multiplexer. It looks at which display is active (from AN_GENERATOR) and sends the correct digit to the BCD decoder.

Example:

- If Display 0 is active → send digit0 (1)
- If Display 1 is active → send digit1 (2)
- If Display 2 is active → send digit2 (3)
- If Display 3 is active → send digit3 (4)

### BCD_DECODER.vhd

Converts a digit (0-9) to the pattern needed to display it on a 7-segment display. It's just a lookup table:

- Input: 0001 (digit 1) → Output: 1001111 (lights up segments to show "1")
- Input: 0010 (digit 2) → Output: 0010010 (lights up segments to show "2")
- etc.

### TOP_MODULE.vhd

Connects all 4 modules together so they work as one system.

## Key Points to Understand

**Active LOW**: Signals use 0 = ON, 1 = OFF. This is because the displays are common-anode (anode always at +5V, pull cathode to ground to light up).
