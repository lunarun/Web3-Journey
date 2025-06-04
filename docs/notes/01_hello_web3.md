# 🎯 01: HelloWeb3

**Related Code:** [`01_HelloWTF.sol`](https://gist.github.com/lunarun/dd5729a5d3eb59a8beeb39e23b080e0c)

## 📌 1. Core Solidity Structure
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3{
    string public _string = "Hello Web3!"; // state Variables
}
```

## 📌 2. Key Concepts
- SPDX License：Legal compliance (for exmaple: MIT, Unlicense)
- pragma solidity ^0.8.21: Specifies compiler version compatibility(兼容性)
- contract Keyword: Defines contract scope.
- state Variables: Data stored permanently on the blockchain. Marked ```public``` for auto-generated ```getter```.

## 📌 3.Compilation and deployment in Remix
1. Press CTRL+S to compile the code.
2. Click ```Deploy & Run Transactions``` tab, and choose ```Remix VM (Prague)``` or ```Remix VM (Cancun)```
3. Click ```Deploy``` button to deploy the contract. 
<img width="348" alt="image" src="https://github.com/user-attachments/assets/6b948c6d-fc2d-4315-a0da-11b751e2d66b" />


4. After a successful deployment, you will see a contract named "HelloWeb3" below, and with a variable ```_string```.
5. Click ```_string``` variable, you will see the value below.
<img width="294" alt="image" src="https://github.com/user-attachments/assets/cb491b5a-ddd6-4aee-ba25-b503cbb5c929" />


