// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Function{
    // function可以有多个返回值
    function returnMany() public pure returns(uint256, bool,uint256){
        return (1,true,2);
    }
    // 返回值可以被命名
    function named() public pure returns (uint256 x,bool b,uint256 y){
        return (1,true,2);
    }
    // 返回值可以被分配其它名字
    // 在这个例子中return语句可以被省略
    function assigned() public pure returns(uint256 x, bool b, uint256 y){
        x = 1;
        b = true;
        y = 2;
    }
    // 调用function使用解构赋值
    // 函数的多个返回值
    function destructuringAssignments() public pure returns (uint256, bool,uint256,uint256,uint256){
        (uint256 i,bool b,uint256 j) = returnMany();
        (uint256 x,,uint256 y) = (4,5,6);
        return (i,b,j,x,y);
    }
    // 不能使用map作为入参或者返回值
    // 可以使用数组作为入参
    function arrayInput(uint256[] memory _arrr) public {}
    // 可以使用数组作为返回值
    uint256[] public arr;
    function arrayOutput() public view returns (uint256[] memory){
        return arr;
    }
}
// 调用function用 key-value作为入参
contract XYZ{
    function someFuncWithManyInputs(
        uint256 x,
        uint256 y,
        uint256 z,
        address a,
        bool b,
        string memory c
    ) public pure returns (uint256){}
    function callFunc() external pure returns(uint256){
        return someFuncWithManyInputs(1, 2, 3, address(0), true, 'c');
    }
    function callFuncWithKeyValue() external pure returns(uint256){
        return someFuncWithManyInputs(
            {
                a:address(0),
                b:true,
                c:"c",
                x:1,
                y:2,
                z:3
            }
        );
    }
}