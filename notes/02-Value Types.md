# 📝 02 - Value Types

**Lesson Source:** [WTF Solidity - Lesson 2: Value Types](https://www.wtf.academy/en/course/solidity101/ValueTypes)

**Related Code:** [`02_ValueTypes.sol`]()

---

## 1. Introduction to Value Types

Value types are varibles, that when assigned to a new varible or passed into a function, always create a **copy** of their data.
They are stored directly in memory or storage.

For example:
```
// assigned to a new varible
uint a = 10;
uint b = a;
```
when ```b = a```, ```b``` will get a copy of the value of ```a```, If change the value of ```a```later, ```b``` won't be affected.
```
// passed into a function, when call test function
function test(uint _value){...do something}
```
when pass ```a``` as a parameter into a function, the function uses a copy of the value of ```a```. Any modifications made to the copy value
within the function will not affect original value of ```a``` in the external environment.


## 2. Common Value Types & Key Characteristics
* **`bool` (Boolean)**:
    * `true` or `false`.
    * Default value: `false`.
    * Used for conditional logic (`if`, `while`).
    * Boolean operators: !, &&, ||, ==, !=
```
// boolean
bool public _bool = true;

// Boolean operators
bool public _bool1 = !_bool; // Logical NOT
bool public _bool2 = _bool && _bool1; // logical AND
bool public _bool3 = (_bool || _bool1); // logical OR
bool public _bool4 = _bool == _bool1; // logical equality
bool public _bool5 = _bool != _bool1; // logical inequality
```
 
* **`uint` / `int` (Integers)**:
    * `uint`: Unsigned integers (non-negative). `uint8` to `uint256` (steps of 8). `uint` defaults to `uint256`.
    * `int`: Signed integers (positive and negative). `int8` to `int256` (steps of 8). `int` defaults to `int256`.
    * **Overflow/Underflow**: A critical point! If an `uint8` variable holds `255` and you add `1`, it will wrap around to `0` (overflow). Use `unchecked` block for intended overflows or Solidity 0.8.0+ automatically reverts on overflow/underflow for arithmetic operations.
    * **Type inference**: `uint a = 1;`
    * **Literals**: `1`, `0x10`, `1e18` (for scientific notation).
