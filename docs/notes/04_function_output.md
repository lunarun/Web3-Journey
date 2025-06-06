# 📝 04 - Function Output (return & returns)

**Lesson Source:** [WTF Solidity - Lesson 4: Function output](https://www.wtf.academy/en/course/solidity101/Return)

**Related Code:** [`04_function_output.sol`](/labs/04_function_output/contract.sol)

---

## 1. Function Output Basics

* ```returns```: Added after function name to declare variable type and name
* ```return```: Used in the function body to return the desired variables.
```
function returnMultiple() public pure returns (uint256, bool, uint256[3] memory) {
    return(1, true, [uint256(1), 2, 5]);
}
```

## 2. Named returns
```
// named returns
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false; 
    _array = [uint256(3),2,1];
    // return (_number, _bool, _array) is optional, can be omitted. It will be automatically executed.
}
```
* Can name the return variables directly within the ```returns``` declaration.
  
* **Benefit**:
  * Solidity automatically initializes these variables to default values (e.g., `0` for `uint`, `false` for `bool`, `address(0)` for `address`)
  * Can assign value to these named variables directly.
  * Solidity will automatically return the values of these named variables without ```return```keywords.

## 3. Returning Multiple Values
* Solidity natively supports returning multiple values using **tuple types**
```
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
```

## 4. Destructuring Assignment (Assigning Partial Return Values)
* When a function returns multiple values (as a tuple), you can assign only a subset of these values to variables.
* Components can be left out by using commas as placeholders.
```
// Read return values, destructring assignments
// 'multiple return values' is considered a tuple: tuple(uint256, bool, uint256[3])
function readReturn() public pure returns (
    uint256 _number,
    bool _bool,
    uint256[3] memory _array
){
    _number = 2;
    _bool = true;
    _array = [uint256(3), 2, 1];
}

function demoPartial() public pure returns (
    bool onlyBool
){
    (, onlyBool,  ) = readReturn();
    // onlyBool == true;
    // return onlyBool;
}
```

For more detailed information, you can refer to the [WTF Solidity - Return lesson](https://www.wtf.academy/en/course/solidity101/Return).
