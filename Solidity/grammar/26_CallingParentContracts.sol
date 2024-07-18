// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// 父合约可以直接调用 也可以通过super关键字调用
// 通过使用super关键字 将调用所有直接父合约
/* Inheritance tree
   A
 /  \
B   C
 \ /
  D
*/
contract A{
    // 这被称为事件 您可以从函数中发出事件 它们被记录到事务日志中 在我们的例子中 这对跟踪函数调用很有用
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo called");
    }
    function bar() public virtual {
        emit Log("A.bar called");
    }    
}
contract B is A{
    function foo() public virtual override {
        emit Log("B.foo called");
        A.foo();
    }
    function bar() public virtual override {
        emit Log("B.bar called");
        super.bar();
    }
}
contract C is A{
    function foo() public virtual override {
        emit Log("C.foo called");
        A.foo();
    }
    function bar() public virtual override {
        emit Log("C.bar called");
        super.bar();
    }
}
contract D is B,C{
    // 尝试：
    // - 调用D.foo() 检查 日志
    // 尽管D继承了 AB和C 但它之后调用C和A
    // - 调用D.bar() 检查 日志
    // 尽管父类调用了两次（B、C） 它只会调用A一次
    function foo() public override (B, C){
        super.foo();
    }
    function bar() public override (B, C){
        super.bar();
    }
}