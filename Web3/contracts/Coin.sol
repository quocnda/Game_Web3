// SPDX-License-Identifier: MIT

pragma solidity >0.8.9;

contract Coin {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint256 public battle_count;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => uint256) public depositOf;
    event Transfer(address _from, address _to, uint256 _value);
    event Approve(address, address, uint256);
    address internal spender_;
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }
    function deposit() public payable {
        depositOf[msg.sender] = msg.value;
        // 0.1 eth 100 token
        uint256 totalTokenRecieve = (msg.value * 10) / (0.1 * 10 ** 18);
        balanceOf[msg.sender] += totalTokenRecieve;
        totalSupply += totalTokenRecieve;
    }
    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        _transfer(msg.sender, _to, _value);
        return true;
    }
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(balanceOf[_from] >= _value, "Insuffienct balance");
        require(_to != address(0), "address 0 recipient");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
    }
    function approve(
        address from,
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        allowance[from][_spender] = _value;
        spender_ = _spender;
        emit Approve(from, _spender, _value);
        return true;
    }
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(allowance[_from][spender_] >= _value, "Insufficient allowance");
        allowance[_from][spender_] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }
    function transferCoinForWinner(address winner) public {
        _transfer(address(this), winner, 40);
    }
    function transferCoinForContract(address from) public {
        _transfer(from,address(this), 20);
    }
}
