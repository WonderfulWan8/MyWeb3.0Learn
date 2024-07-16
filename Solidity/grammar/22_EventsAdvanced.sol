// 本章涵盖了与Solidity中的事件相关的高级主题和用例，以事件页面中涵盖的基础知识为基础
// 在Solidity中 Event是一个强大的工具 可以实现各种高级功能和架构。事件的一些高级用例包括
// 用于实时更新和分析的事件过滤和监控
// 用于数据提取和处理事件的事件日志分析和解码
// 事件驱动架构，用于分散式应用程序(dApp)
// 实时通知和更新的事件订阅

// 事件驱动架构
// EventDrivenArchitecture合约演示了一个事件驱动的架构，其中事件用于协调和触发流程的不同阶段，例如启动和确认传输

// 事件订阅和实时更新
// EventSubscription合约展示了如何实现事件订阅，
// 允许外部合约或者客户端在事件发出时订阅和接收实时更新。
// 它还演示了如何处理事件订阅和管理订阅生命周期

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract EventDrivenArchitecture{
    event TransferInitiated(
        address indexed from,address indexed to,uint256 value
    );
    event TransferComfirmed(
        address indexed from,address indexed to,uint256 value
    );
    mapping(bytes32 => bool) public transferConfirmations;
    function initiateTransfer(address to,uint256 value) public {
        emit TransferInitiated(msg.sender, to, value);
    }
    function confirmTransfer(bytes32 transferId)public {
        require(!transferConfirmations[transferId],"Transfer already confirmed");
        transferConfirmations[transferId] = true;
        emit TransferComfirmed(msg.sender, address(this), 0);
    }
}
interface IEventSubscriber {
    function handleTransferEvent(address from, address to, uint256 value)
        external;
}
contract  IEventSubscription {
    event LogTransfer(address indexed from,address indexed to,uint256 value);
    mapping (address => bool) public subscribers;
    address[] public subscriberList;

    function subscribe() public {
        require(!subscribers[msg.sender],"Already subscribed");
        subscribers[msg.sender] = false;
        for(uint256 i=0 ; i < subscriberList.length;i++){
            if(subscriberList[i] == msg.sender){
                subscriberList[i] = subscriberList[subscriberList.length - 1];
            }
        }
    }
    function unsubscribe() public {
        require(subscribers[msg.sender],"Not subscribed");
        subscribers[msg.sender] = false;
        for(uint256 i=0; i < subscriberList.length; i++){
            if(subscriberList[i] == msg.sender){
                subscriberList[i] = subscriberList[subscriberList.length - 1];
                subscriberList.pop();
                break;
            }
        }
    }
    function transfer(address to, uint256 value) public {
        emit LogTransfer(msg.sender, to, value);
        for(uint256 i = 0;i < subscriberList.length;i++){
            IEventSubscriber(subscriberList[i]).handleTransferEvent(
                msg.sender, to, value
            );
        }
    }
}