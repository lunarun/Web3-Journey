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
 
* **`address`**:
    * Represents a 20-byte(160-bit) Ethereum blockchain account addresses (e.g., `0x...`).
    * Can hold EOA (Externally Owned Account) addresses or contract addresses.
    * It only stroes addresses itself. Does not contain any other informations.
    * **Usage**:
        * Storing account addresses, such as the contract owner.
        * As a function parameter, it presents the sender or receiver of the transaction.
        * As a mapping key, it associates addresses with certain data.
        * Default value: address(0) or 0xO.
    * **Special properties**:
        * `.balance`: Checks the Ether balance of an address (e.g., `myAddress.balance`).
        * `.transfer()`, `.send()`, `.call()`: Functions to send Ether (use `.call()` for secure Ether transfer in modern Solidity due to reentrancy concerns).
    * **Zero Address**: `address(0)` is often used to initialize addresses or to indicate invalid addresses or to destroy addresses (sending Ether to the zero address will permanently destroy them).
    * **`address payable`**: A specific type for addresses that *can* receive Ether. Functions interacting with Ether transfers often require this.
        * from **address** to **address payable** : need use **payable()** to explicit type casting.
        * from **address payable** to **address**: need use **address()** to explicit type casting.
        * **Member Functons**:
            * **.balance**: ```uint256 contractBalance = address(this).balance;```, return type```uint256```
            * **_addr.transfer(uint256 amount)**:
                * send Ether to **_addr**.
                * Can only be used for **address payable** type.
                * When sending failed, raise an exception and rollback.
                * It will forward **2300 gas** to recipient. It's the **minimum** amount gas required by the recipient to excute **receive()** or **fallback()**.
                * ```Example: payableAddress.transfer(1 ether)```
            * **_addr.send(uint256 amount)**:
                * send Ether to **_addr**.
                * Can only be used for **address payable** type.
                * When sending failed, return **false** without an exception. You need to check the return value manually. Like **transfer**, it only forward **2300 gas**. Because no exception thrown, it needs to be used more cautiously. Must check the return value.
            * **.call(bytes memory data)**:
                * Recommanded for complex Ether transactions and external calls.
                * Can be used for **address** and **address payable** types.
                * When sending failed, return ```(bool success, bytes memory data)```. You need to check ```success``` manually.
                * By default, all avaliable gas will be forwarded to the caller (unless you explicitly specify gas limits)
                * Must according to **Checks-Effects-Interactions** model. **Reentrancy Attacks**.
```
address public nonPayableAddress;
address payable public _payableAddress; // declare a payable address

constructor() {
   // msg.sender is always address payable type, because it is the sender of the transaction.
    payableAddress = payable(msg.sender); 
    nonPayableAddress = msg.sender;
}

function sendEther(address payable _recipient) public payable {
    _recipient.transfer(msg.value);
}

function retrievePayableAddress() public view returns (address payable) {
    return payableAddress; 
}
// error：
// function wontCompile(address _toAddress) public payable {
//     _toAddress.transfer(msg.value); // error！_toAddress is not payable
// }
```

* **`bytes` (Fixed-size byte arrays)**:
    * `bytes1` to `bytes32`. `bytes` is dynamic.
    * Fixed-size byte arrays: store a fixed sequence/arrays of bytes. The length of the array cannot be modified after declaration.
    * Variable-length byte arrays: belong to reference type, including bytes, etc.
    * `bytes32` is commonly used for hashes (e.g., `keccak256` output).

* **`enum` (Enumerated Types)**:
    * User-defined type that represents a set of named constants.
    * Each enum member implicitly maps to an integer, starting from 0.
    * **Example**:
        ```solidity
          // unit 0， 1， 2 represent Buy, Hold, Sell
          enum ActionSet { Buy, Hold, Sell }
          // Create an enum variable called action
          ActionSet public action = ActionSet.Buy;
        ```
        <img width="151" alt="image" src="https://github.com/user-attachments/assets/aa2d304d-41a1-4cd4-ad16-43d308d58e94" />

