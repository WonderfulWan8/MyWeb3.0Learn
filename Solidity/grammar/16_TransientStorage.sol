// SPDX-License-Identifier: MIT
// 瞬态存储
// 存储在瞬态存储中的数据 会在交易后被删除
pragma solidity ^0.8.24;
// 确保 evm版本和vm设置到 canrun
// Storage - 数据被存储在区块链
// Memory - 数据在函数调用结束后被清理
// Transient Storage - 数据在交易结束后被清理
interface ITest {
    function val() external view returns(uint256);
    function test() external;
}
contract Callback {
    uint256 public val;
    fallback() external {
        val = ITest(msg.sender).val();
     }
     function test(address target) external {
        ITest(target).test();
     }
}
contract TestStorage{
    uint256 public val;
    function test() public {
        val = 123;
        bytes memory b = "";
        msg.sender.call(b);
    }
}
contract TestTransientStorage{
    bytes32 constant SLOT = 0; 
    function test() public {
        // assembly 块用于内联的低级EVM（Ethereum Virtual Machine）汇编代码。这些汇编指令直接操作EVM的状态和内存，提供了比高级Solidity代码更底层的控制。
        // tstore是一个汇编指令，用于将32字节的值（在这个例子中是321，它会被转换为一个32字节的值）存储在由SLOT指定的存储槽（storage slot）中
        assembly{
            tstore(SLOT,321)
        }
        bytes memory b = "";
        msg.sender.call(b);
    }
}
contract ReentrancyGuard{
    bool private locked;
    modifier lock(){
        require(!locked);
        locked = true;
        _;
        locked = false;
    }
    function test() public lock{
        // 忽略报错
        bytest memory b = "";
        msg.sender.call(b);
    }
}