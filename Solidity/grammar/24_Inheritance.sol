// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/* Graph of inheritance
    A
   / \
  B   C
 / \ /
F  D,E

*/
contract A{
    function foo() public pure virtual returns (string memory){
        return 'A';
    }
}
// 合约通过is关键字继承其它合约
contract B is A{
    // 重写A的foo方法
    function foo() public pure virtual override returns (string memory){
        return "B";
    }
}
contract C is A{
    function foo() public pure virtual override returns (string memory){
        return "C";
    }
}
// 合约可以继承多个合约 当函数调用多个父合约中都定义的函数时 父合约会从右往左深度优先
contract D is B, C{
    // 在这里 D.foo() 返回值为 'C'
    function foo() public pure override(B,C) returns (string memory){
        return super.foo();
    }
}
contract E is C,B {
    // 在这里 E.foo() 返回值为 'B'
    // 因为B是继承列表里最右边且带有foo()函数的合约
    function foo() public pure override (C,B) returns (string memory){
        return super.foo();
    }
}

// 在继承的时候 应该最基类应该写在最前面 如上图 继承顺序为  A,B,F OK 如果A不是在最前面则会报错
contract F is A,B{
    function foo() public pure override (A,B) returns (string memory){
        return super.foo();
    }
}