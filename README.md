# Assembly Calculator

A simple graphical calculator built in x86 Assembly language for division and square root calculations using custom algorithms.

## Features

- **Graphical Interface**: VGA graphics mode (320x200, 256 colors).
- **Mouse Support**: Interactive virtual keyboard controlled by mouse clicks.
- **Operations**:
  - Integer Division (quotient and remainder).
  - Integer Square Root calculation.
- **Input Validation**: Supports up to 5-digit numbers.
- **Negative Numbers**: Supported for division operations.

## Interface

### Main Menu
- **DIVISAO**: Division operation.
- **RAIZ QUADRADA**: Square root calculation.
- **SAIR**: Exit the program.

### Virtual Keyboard
- Digits 0-9.
- Negative sign (-) for division.
- **DELETE**: Correct input errors.
- **RESULTADO**: Execute calculations.

## Algorithms

### Division
- Processes dividend digits from most to least significant.
- Calculates how many times the divisor fits for each digit.
- Updates quotient and remainder iteratively.

### Square Root
- Groups digits in pairs from right to left.
- Finds the largest digit whose square fits the current group.
- Continues for remaining digit pairs to compute the integer square root.

## Technical Details

- **Language**: x86 Assembly (8086/8088 compatible).
- **Graphics Mode**: VGA Mode 13h (320x200, 256 colors).
- **Input**: Mouse-driven virtual keyboard.
- **Max Input**: 5-digit numbers.
- **Output**: Integer results only.
