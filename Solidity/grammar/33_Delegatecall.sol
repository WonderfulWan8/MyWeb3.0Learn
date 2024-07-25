// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// 注意：首先部署此合约
contract B{
    // 存储布局必须与合约A相同
    uint256 public num;
    address public sender;
    uint256 public value;
    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}
contract A{
    uint256 public num;
    address public sender;
    uint256 public value;
    function setVars(address _contract,uint256 _num) public payable {
        // a 的 storage已设置 而b未修改
        (bool success,bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}