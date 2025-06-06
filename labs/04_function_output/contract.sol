// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


contract FunctionOutput{
        // returning multiple variables
        // returns - declare variable type and variable name
        function returnMultiple() public pure returns (uint256, bool, uint256[3] memory) {
            // return - to return desired variables
            return(1, true, [uint256(1), 2, 5]);
        }

        // Named returns
        function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array) {
            // can only assign values to these three varibles, and they will automatically return without return() keyword.
            _number = 2;
            _bool = false; 
            _array = [uint256(3),2,1];
            // The return statement is omitted, because Solidity automatically execute it at the end of the function.
            // without explicit return (_number, _bool, _array);
        }

        // Named return, still support return
        function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
            return(1, true, [uint256(1),2,5]);
        }

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

        // if want to extract these values above
        function demoFull() public pure returns (
            uint256 a, bool b, uint256[3] memory arr
        ){
            uint256    _number;
            bool       _bool;
            uint256[3] memory _array;

            (_number, _bool, _array) = readReturn();
            // now _number == 2, _bool == true, _array == [3,2,1]
            a = _number;
            b = _bool;
            arr = _array;
            // without explicit return (a, b, arr)
        }

        // 
        function demoPartial() public pure returns (
            bool onlyBool
        ){
            (, onlyBool,  ) = readReturn();
            // onlyBool == true;
            // return onlyBool;
        }
}
