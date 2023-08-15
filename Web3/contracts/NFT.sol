// SPDX-License-Identifier: MIT
pragma solidity >0.8.9;
contract NFT {
    address  owner;
    address  spender_;
    struct Item{
        string name;
        uint256 id;
        string image;
        uint256 stock; 
    }
    Item[] public items;
    constructor () {
        owner = msg.sender;
    }
    mapping (address => mapping(uint256 => uint256)) public balanceOf;
    mapping (address => mapping (address => mapping (uint256=> uint256))) public approve;

    function list(string memory name_,
    uint256 id_,
    string memory image_,
    uint256 stock_
    ) public  {
        require(msg.sender == owner);
        Item memory item = Item(name_,id_,image_,stock_);
        items.push(item);
        balanceOf[msg.sender][id_] = stock_;

    }
 
    function  allowance(address from,address spender , uint256 _id,uint256 amount) public {
        approve[from][spender][_id] = amount;
        spender_ = spender;
    }
    function transferFrom(address from, address to , uint256 id_,uint256 amount) public  {
        uint256 stock = balanceOf[from][id_];
        uint256 appro_stock = approve[from][spender_][id_];
        require(stock>=amount,"checkvar man");
        require(appro_stock>=amount,"check var o day man");
        approve[from][spender_][id_] -= amount;
        _transfer(from, to, id_, amount);
    }
     function _transfer(address _from, address _to, uint256 _id,uint256 _amount) internal {
        require(balanceOf[_from][_id] >= _amount, "Insuffienct balance");
        require(_to != address(0), "address 0 recipient");
        balanceOf[_from][_id] -= _amount;
        balanceOf[_to][_id] += _amount;
    }
}