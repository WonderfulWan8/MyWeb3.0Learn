// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Enum{
    enum Status{
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    // 枚举的默认值是列表的第一个
    // 在这个例子中就是Pending
    Status public status;
    // 返回值是uint
    // Pending - 0
    // Shipped - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4
    function get() public view returns(Status){
        return status;
    }
    function set(Status _status) public {
        status = _status;
    }
    function cancel() public {
        status = Status.Canceled;
    }
    function reset() public {
        delete status;
    }   
}