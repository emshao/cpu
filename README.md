# Processor
## NAME
Emily Shao (eys9)

## Description of Design
Designed 5-stage pipeline for CPU that includes all ALU operations, multiplication and division components, branching, jumping, setting/reading registers, and loading/storing in memory. 

## Bypassing
Bypass logic happens within the Decode, Execute, and Memory stages for each of the proceses that happen after it. 

## Stalling
Stalling occurs during ALU operations and multiplication/division calculations. Stalling pauses the previous latching from committing, continues the latches of the instructions before the stall operation, and pushes nop's in the second half of the stages in order to finish the instructions

## Optimizations
Detection of jumped branching within the fetch stage, setting all branch changes within the execute stage, 

## Bugs
Bypass bigs immediately branching after writing to a register, branching after jumping, and storing/loading words when bypassing. 