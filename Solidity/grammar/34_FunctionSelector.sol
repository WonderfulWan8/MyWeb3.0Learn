// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// 当一个函数被调用时，calldata的前4个自己指定要调用的函数
// 这4个字节称为函数选择器
// 比如下面这段代码，它使用call在地址addr处的合约上执行转账
// addr.call(abi.encodeWithSignature("transfer(address,uint256)", 0xSomeAddress,123);
// 从abi.encodeWithSignature(......)返回的4个字节是函数选择器
// 如果您在代码中预先计算并内联函数选择器，也许可以节省少量gas
// 下面是如何计算函数选择器
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract FunctionSelector{
    /*
        transfer（address，uint 256）
        0xa9059cbb
        transferFrom（address，address，uint256）
        0x23b872dd
    */
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}