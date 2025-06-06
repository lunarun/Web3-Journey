# 📝 05 - Data Storage

**Lesson Source:** [WTF Solidity - Lesson 5: Data Storage](https://www.wtf.academy/en/course/solidity101/DataStorage)

**Related Code:** [`05_DataStorage.sol`](/labs/05_storage_and_scope/contract.sol)

---
## 1. Data Storage Location

In Solidity, understanding where data is stored is crucial for gas optimization and correct contract behavior.

The primary three storage locations in Solidity: ```storage```,```memory```,```calldata```.

Gas costs, mutability and lifetime of these three locations are different.

## 2. Storage
* **Location:** On-chain storage (like a hard disk).
* **Characteristics:**
  * **Persistent**: Data is permanently stored on-chain.
  * **Expensive**: Consumes a significant amount of gas (especially for writing and modifying).
  * **Mutable**: Data can be read and write to.
* **Usage:**
  * **state Variables**: State variables are stored in 'storage' by default. This is where contract's long-term data resides.
 
## 3. Memory
* **Location:**  memory, temporary during function execution.
* **Characteristics:**
  * **Temporary**: Data exits only during function execution.
  * **Less expensive than storage**
  * **Mutable**: Data can be read and write to within the function's scope.
* **Usage:**
  * **Function Parameters**
  * **Local Variables:** Temporary variables declared within functions.

## 4. Calldata
* **Location:** Special read-only, non-modifiable area for function arguments.
* **Characteristics:**
  * **Temporary:** Data exists only for the duration of an external function call.
  * **Cheapest for External Parameters:** Generally the cheapest way to pass complex data as parameters to external functions, as it's read-only.
  * **Immutable:** Data cannot be modified.
* **Usage:**
    * **External Function Parameters:** Primarily used for parameters of `external` functions.
    * **Contract Creation Arguments:** Arguments passed to a contract's constructor during deployment.
 
## 5.Assignment Behaviour
* **Storage is assigned to a local storage**:
  * Create a reference.
  * Affect: The changing value of the new variable will affect the original one.
```
uint[] x = [1, 2, 3]; // state variable, stored in storage

// 1. storage -> storage -> create a reference -> affect
function fStorageToStorage() public {
    // Declare a storage variable 'xStorage', pointing to 'x'. If modify 'xStorage' will also affect 'x'.
    uint[] storage xStorage = x;
    xStorage[0] = 100;
}
```
* **Storage is assigned to memory**:
  * Create independent copies.
  * Affect: Will not affect each other.
```
// 2. storage → memory -> perform a deep copy -> no affect
function fStorageToMemory() public view returns (uint[] memory) {
    // whenever 'storage' is assigned to 'memory', a deep copy is performed.
    uint[] memory xMemory = x;
    // xMemory and x are competely separate data spaces.
    // If modify 'xMemory' won't affect 'x'.
    xMemory[0] = 200;
    return xMemory;
}
```
* **Memory is assigned to memory**:
  * Create a reference.
  * Affect: The changing value of the new variable will affect the original one.
```
// 3. memory -> memory -> create a reference -> affect
function fMemoryToMemory(uint[] memory arr) public pure returns(uint[] memory, uint[] memory) {
    uint[] memory temp = arr; // arr has been in memory.
    temp[1] = 666;
    return (arr, temp);
}
```
* **Memory is assigned to storage**:
  * Create independent copies.
  * Affect: Will not affect each other.
```
// 4. memory -> storage -> deep copy -> no affect
function fMemoryToStorage(uint[] memory arr) public {
    // uint256[] storage localRef = arr; // ❌ TypeError: Type uint256[] memory is not implicitly convertible to expected type uint256[] storage
    // localRef[1] = 777;
    // return (arr);
    // ✅ It is possible to directly assign the memory array to an existing storage array.
    x = arr;
}
```

* **Calldata is assigned to memory**:
  * Just a copy. Allowed to modify.
  * Affect: Will not affect each other.
```
// 3. calldata -> memory -> just a copy -> no affect
// If change copyArr won't affect calldata arr.
function fCalldataToMemory(uint[] calldata arr) public pure returns(uint[] memory) {
    uint[] memory copyArr = arr;
    copyArr[1] = 123;
    return copyArr;
}
```
* **Calldata is assigned to storage**:(❌ not allowed)
  * Calldata is just a buffet, the complier does not allowed it to be directly assigned to storage.
  * If want to assign calldata to storage, need to copy it to a memory array first.
  * Then write the contents of the memory array into the state variable one by one or as a whole.
```
function fCalldataToStorage(uint[] calldata arr) public {
    // uint[] storage bad = arr; // error: ：Cannot assign calldata to storage
    // copy calldata to memory
    uint[] memory temp = arr;
    delete x; // clean x first
    for(uint i = 0; i < temp.length; i++){
        // write contents of memory into x.
        x.push(temp[i]);
    }
}
```

---
For more detailed information, you can refer to the [WTF Solidity - Data Storage lesson](https://www.wtf.academy/en/course/solidity101/DataStorage).

