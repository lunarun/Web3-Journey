# 📝 03 - Function

**Lesson Source:** [WTF Solidity - Lesson 3: Value Types](https://www.wtf.academy/en/course/solidity101/Function)

**Related Code:** [`03_Function.sol`]()

---

## 1. Function Format & Structure
```
function <function name>(<parameter types>) [public|private|internal|external] [pure|view|payable] [returns (<return types>)]
```

* **function**: To write a function, you need to start with the keyword function.
* **function name**: The name of the function.
* **parameter types**: The input parameter types and names.
* **[internal|external|public|private]**: Function visibility specifiers. There is no default visibility, so you must specify it for each function. There are 4 kinds of them:
  * **public**: Visible to all. Public is the **default** visibility for functions
  * **private**: Can only be accessed within this contract, derived contracts cannot use it.
  * **external**: Can only be called from other contracts. But can also be called by this.f() inside the contract, where f is the function name.
  * **internal**: Can only be accessed internally and by contracts deriving from it. The **default visibility for state variables** is internal
  * **public|private|internal** can be also used on state variables. Public variables will automatically generate getter functions for querying values. Note 2: .
  * **[pure|view|payable]**: Keywords that dictate a Solidity functions behavior. payable is easy to understand. One can send ETH to the contract via payable functions.
  * **[returns (<return types>)]**: Return variable types and names.
