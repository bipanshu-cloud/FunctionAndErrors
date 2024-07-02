// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract pizzaPlacing {
    uint public CountOrder;
    mapping(uint => address) public orderOwners;
    mapping(uint => uint) public orderPizza;
    mapping(uint => bool) public isDelivered;
    mapping(uint => bool) public isRejected;
    
    event OrderDelivered(uint orderNumber, address client);
    event OrderRejected(uint orderNumber, address client);
    

    // REQUIRE FUNCTION()
    function placeOrder(uint SelectPizza) public payable returns(uint) {
        require(msg.value >= 1, "The Required Payment not met!");
        CountOrder++;
        orderOwners[CountOrder] = msg.sender;
        orderPizza[CountOrder] = SelectPizza;
        return CountOrder;
    }
    
    // ASSERT FUNCTION()
    function delivered(uint orderNumber) public {
    assert(orderOwners[orderNumber] == msg.sender && !isDelivered[orderNumber]);
    
    isDelivered[orderNumber] = true;
    emit OrderDelivered(orderNumber, msg.sender);
    }

    // REVERT FUNCTION()
    function rejectOrder(uint orderNumber) public {
    if (orderOwners[orderNumber] != msg.sender || isRejected[orderNumber]) {
        revert("Order does not exist or has already been rejected");
    }

    isRejected[orderNumber] = true;
    emit OrderRejected(orderNumber, msg.sender);
}

}
