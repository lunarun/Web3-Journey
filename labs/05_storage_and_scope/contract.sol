// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract DataStorage {
    uint[] x = [1, 2, 3]; // state variable, stored in storage

    // 1. storage -> storage -> create a reference -> affect
    function fStorageToStorage() public {
        // Declare a storage variable 'xStorage', pointing to 'x'. If modify 'xStorage' will also affect 'x'.
        uint[] storage xStorage = x;
        xStorage[0] = 100;
    }
    
    // 2. storage → memory -> perform a deep copy -> no affect
    function fStorageToMemory() public view returns (uint[] memory) {
        // whenever 'storage' is assigned to 'memory', a deep copy is performed.
        uint[] memory xMemory = x;
        // xMemory and x are competely separate data spaces.
        // If modify 'xMemory' won't affect 'x'.
        xMemory[0] = 200;
        return xMemory;
    }

    // 3. calldata -> memory -> just a copy -> no affect
    // If change copyArr won't affect calldata arr. Just a copy.
    function fCalldataToMemory(uint[] calldata arr) public pure returns(uint[] memory) {
        uint[] memory copyArr = arr;
        copyArr[1] = 123;
        return copyArr;
    }

    // 4. calldata -> storage (❌ cannot)
    // calldata is just a buffet, the complier does not allowed it to be directly assigned to storage 
    // If want to assign calldata to storage, need to copy it to a memory array first.
    // Then write the contents of the memory array into the state variable one by one or as a whole.
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

    // 5. memory -> memory -> create a reference -> affect
    function fMemoryToMemory(uint[] memory arr) public pure returns(uint[] memory, uint[] memory) {
        uint[] memory temp = arr;
        temp[1] = 666;
        return (arr, temp);
    }

    // 6. memory -> storage -> deep copy -> no affect
    
    function fMemoryToStorage(uint[] memory arr) public {
        // uint256[] storage localRef = arr; // ❌ TypeError: Type uint256[] memory is not implicitly convertible to expected type uint256[] storage
        // localRef[1] = 777;
        // return (arr);
        // ✅ It is possible to directly assign the memory array to an existing storage array.
        x = arr;
    }

    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata) {
        //The parameter is the calldata array, which cannot be modified.
        // _x is stored in the EVM's input buffer.
        // _x[0] = 0; //This modification will report an error.
        return(_x);
    }

    // xStorage is just created as a 'storage reference' temporarily, it's not a state variable, so won't be compiled and stored.
    // So Remix UI panel won't list it separately.
    // Can add 'getter' to check the modified 'x'.
    function getX() public view returns (uint[] memory) {
        return x;
    }


}