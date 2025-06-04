// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract ValueTypes {
    // boolean
    bool public _bool = true;

    // Boolean operators
    bool public _bool1 = !_bool; // Logical NOT
    bool public _bool2 = _bool && _bool1; // logical AND
    bool public _bool3 = (_bool || _bool1); // logical OR
    bool public _bool4 = _bool == _bool1; // logical equality
    bool public _bool5 = _bool != _bool1; // logical inequality

    // Integer
    int public _int = -1; // Including negative intergers and 0
    uint public _uni1 = 1; // Unsigned intergers including 0 and positive numbers. unit defaults to unit256.
    uint256 public _number1 = 20220330; // unit256 means 256-bit unsigned integers. 
    uint8 public _number2 = 255; // uint8 means 2^8-1 = 255 decimal value is maximum

    // Integer operations
    uint256 public _number3 = _number1 + 1; // +, -, *, /
    uint256 public _number4 = 2**2; // Exponent
    uint256 public _number5 = 7 % 2; // Modulo (Modulus)
    bool public _numberbool = _number2 > _number3; // Greater than

    // Address - Holds a 20 byte value (size of an Ethereum address)
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71; // declare a public address variable
    
    address public nonPayableAddress;
    // address payable type
    address payable public _payableAddress; // declare a payable address
    address payable public _paymentAddress1 = payable(_address);
    address[] public _singleAddresses = [_address];
    // Members of address
    uint public balance = _paymentAddress1.balance;

    address public owner;
    address beneficiary; // declare an address variable

    // Fixed-size byte arrays
    bytes32 public _byte32 = "MiniSolidity";
    bytes1 public _byte1 = _byte32[0];

    // unit 0， 1， 2 represent Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // Create an enum variable called action
    ActionSet public action = ActionSet.Buy;

    constructor() {
        owner = msg.sender; // Assign the address of the delopyer to 'owner' when deloying
         // msg.sender is always address payable type, because it is the sender of the transaction.
        _payableAddress = payable(msg.sender); 
        nonPayableAddress = msg.sender;
    }

    function setBeneficiary(address _newBeneficiary) public {
        beneficiary = _newBeneficiary; // The function accepts an address as parameter and assigns it to the 'beneficiary
    }

    function sendEther(address payable _recipient) public payable {
        _recipient.transfer(msg.value); // can send ether to _recipient
    }

    function retrievePayableAddress() public view returns (address payable) {
        return _payableAddress; // return payable address
    }
}