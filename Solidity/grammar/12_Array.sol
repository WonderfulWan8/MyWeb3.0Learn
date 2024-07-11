// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Array{
    uint256[] public arr;
    uint256[] public arr2 = [1,2,3];
    // 定长数组 所有元素初始化为0
    uint256[10] public myFixedSizeArr;
    // view代表这个函数是只读
    function get(uint256 _i) public view returns(uint256){
        return arr[_i];
    }
    // solidity可以返回整个数组 但是这个方法应该尽量避免 因为数组的长度可能是无限长
    function getArr()public view returns (uint256[] memory){
        // memory 关键字用于指示变量应该被存储在函数调用期间的内存中，而不是合约的永久存储中，这样可以避免不必要的存储操作。
        return arr;
    }
    function push(uint256 i) public {
        arr.push(i);
    }
    function pop() public {
        arr.pop();
    }
    function getLength() public view returns(uint256){
        return arr.length;
    }
    function remove(uint256 index) public {
        // 删除不会改变数组长度 会把当前下标的值设置默认值 在这里是0
        delete arr[index];
    }
    function examples() external {
        // 在内存中创建数组 只能创建固定大小
        uint256[] memory a = new uint256[](5);
    }
}

contract ArrayRemoveByShifting{
    // 删除元素是从右往左
    // [1,2,3] -- remove(1) --> [1,3,3] --> [1,3]
    // [1,2,3,4,5,6] -- remove(2) --> [1,2,4,5,6,6] --> [1,2,4,5,6]
    // [1,2,3,4,5,6] -- remove(0) --> [2,3,4,5,6,6] --> [2,3,4,5,6]
    // [1] -- remove(0) --> [1] --[]
    uint256[] public arr;
    function remove(uint256 _index) public{
        require(_index < arr.length,"index out of bound");
        for(uint256 i = _index; i < arr.length - 1 ; i++){
            arr[i] = arr[i+1];
        }
        arr.pop();
    }
    function test() external {
        arr = [1,2,3,4,5,6];
        remove(2);
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);
        arr = [1];
        remove(0);
        assert(arr.length == 0);
    }
}
// 从最后一个删除数组元素，
contract ArrayReplaceFromEnd{
    uint256[] public arr;
    function remove(uint256 index) public {
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
    function test() public {
        arr = [1,2,3,4];
        remove(1);
        // [1,4,3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);
        remove(2);
        // [1,4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);

    }
}