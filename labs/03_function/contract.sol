// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract FunctionType{
    uint public number = 5;

    // Must specify visibility specifier, because there is no default type.
    // pure - cannot read, cannot write
    function add(uint256 _number) external pure returns (uint256 new_number) {
        new_number = _number + 1;
    }

    // view - can read， cannot write
    function add2() external view returns (uint256 new_number) {
        new_number = number + 1;
    }

    function minus() internal {
        number = number - 1;
    }

    function minusCall() external {
        minus();
    }

    // money(ETH) can be sent to this contract via this payable function
    // First collect payment, then execute the minus() logic. 
    // Receive ETH -> Execute business logic -> Query balance and return
    function minusPayable() external payable returns (uint256 balance) {
        // step 1: Receive ETH, update balance.
        minus(); // step 2: Execute business logic
        balance = address(this).balance; // step 3: Query balance
    }
}