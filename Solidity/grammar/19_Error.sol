// 错误将撤销 transition 期间对状态做出的所有更改
// 可以通过调用require、revert、assert来抛出错误
// require用于在执行之前验证输入和条件
// revert和require类似 具体详见下列代码
// assert用于检查不应该为false的代码,断言失败可能意味着存在bug
// 可以使用自定义Error来节省gas

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Error{
    function testRequire(uint256 _i) public pure {
        // require 应该被用来验证条件 比如：
        //  - inputs
        //  - 运行的前置判断条件
        //  - 调用其他函数的返回值
        require(_i > 10, "Input must be greater than 10");
    }
    function testRevert(uint256 _i) public pure {
        // 当需要判断的条件非常复杂时，revert非常有用
        // 这段代码与上一个例子所做的事情完全相同
        if(_i <= 10){
            revert("Input must be greater than 10");
        }
    }
    uint256 public num;
    function testAssert() public view {
        // Assert应该只用于测试内部错误
        // 并检查不变量

        // 这里我们assert num == 0
        // 因为不可能更新num的值
        assert(num == 0);
    }
    // 自定义错误
    error InsufficientBalance(uint256 balance,uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view{
        uint256 bal = address(this).balance;
        if(bal < _withdrawAmount){
            revert InsufficientBalance({
                balance:bal,
                withdrawAmount:_withdrawAmount
            });
        }
    }
}

// 这里是另一个例子
contract Account{
    uint256 public balance;
    uint256 public constant MAX_UINT = 2 ** 256 -1;

    function deposit(uint256 _amount) public {
        uint256 oldBalance = balance;
        uint256 newBalance = balance+_amount;

        require(newBalance >= oldBalance,"Overflow");
        balance = newBalance;
        assert(balance >= oldBalance);
    }
    function withdraw(uint256 _amount) public {
        uint256 oldBalance = balance;
        require(balance>=_amount,"Underflow");
        if(balance < _amount){
            revert("Underflow");
        }
        balance -= _amount;
        assert(balance<=oldBalance);
    }
}