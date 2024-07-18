// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract A{
    string public name = "Contract A";
    function getName() public view returns (string memory){
        return name;
    }
}
// shadowing 在solidity 0.6中不允许
// contract B is A{
//     string public name = "Contract B";
// }
contract C is A{
    // 这里是正确的方式来改写继承状态变量
    constructor(){
        name = "Contract C";
    }
    // C.getName returns "Contract C"
}