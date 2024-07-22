// 函数和状态变量必须声明它们是否可以被其他合约访问
// 函数可以声明为：
// public - 任何合约和方法可以调用
// private - 仅在定义函数的合约中
// internal - 仅继承内部函数的内部合约
// external - 只有其它合约和其它账户可以调用
// 状态变量可以声明为public private 或者 internal 但不能声明为 external
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Base{
    // Private 方法只能在合约内部被调用 
    // 继承此合约的合约不能调用此函数
    function privateFunc() private pure returns (string memory){
        return "private function called";
    }
    function testPrivateFunc() public pure returns (string memory){
        return privateFunc();
    }   
    // 内部方法 可以 - 在函合约内被调用 - 可以在继承此合约的合约内部被调用
    function internalFunc() internal pure returns (string memory){
        return "internal function called";
    }
    function testInternalFunc() public pure virtual returns (string memory){
        return internalFunc();
    }
    // 公共方法可以被 - 合约内部被调用 - 继承此合约的合约内部被调用 - 其它合约和账户
    function publicFunc() public pure returns(string memory){
        return "public function called";
    }
    // 外部方法 - 可以被其它合约和账户调用
    function externalFunc() external pure returns (string memory){
        return "external functions called";
    }
    // 下面的 外部方法例子 在我们调用时将不会被编译
    // function testExternalFunc() public pure returns(string memory){
    //     return externalFunc();
    // }
}
contract Child is Base{
    // 继承的合约没有权限访问私有方法以及私有状态变量
    // function testPrivateFunc();
    
    // 继承方法可以在子合约中被调用
    function testInternalFunc() public pure override returns(string memory){
        return internalFunc();
    }
}