// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// import "hardhat/console.sol";

interface INFT {
         function transferFrom(address from , address to, uint256 tokenId,uint256 amount) external;
         function balanceOf(address,uint256) external returns(uint256);
         function allowance(address,address,uint256,uint256) external ;
         function approve(address,address,uint256,uint256)external ;
    }
interface ICOIN {
    function transferFrom(address,address,uint256) external ;
    function approve(address,address, uint256) external ;
    function balanceOf(address) external  returns(uint256) ;
}
contract Marketplace  {

    // Variables
    address payable public immutable feeAccount; // the account that receives fees
    uint public immutable feePercent; // the fee percentage on sales 
    uint public itemCount; 
    address add_nft;
    address add_coin;

    uint256 public feeGas;
    uint256 public  total_pric;

    struct Item {
        uint256 itemId;
        uint price;
        uint256 amount;
        address payable seller;
    }
    INFT public nft;
    ICOIN public coin;
    // itemId -> Item
    mapping(uint256 => Item) public items;



    constructor(uint _feePercent,address NFT,address a_coin) {
        feeAccount = payable(msg.sender);
        feePercent = _feePercent;
        nft = INFT(NFT);
        add_nft = NFT;

        coin = ICOIN(a_coin);
        add_coin = a_coin;
    }
    
    // function check_appro(uint256 _tokenId,uint256 amount) public {
    //             nft.allowance(add_nft,_tokenId , amount );
    // }
    // Make item to offer on the marketplace
    function makeItem(uint256 _tokenId,uint256 amount, uint256 _price) public payable   {
        require(_price > 0, "Price must be greater than zero");
        // increment itemCount
        itemCount ++;
        address  tmp = msg.sender;
        // transfer nft
        nft.allowance(tmp,add_nft,_tokenId , amount );
        nft.transferFrom(tmp,address(this), _tokenId,amount);
        // add new item to items mapping
        items[itemCount] = Item(
            _tokenId,
            _price,
            amount,
            payable(msg.sender)
            
        );
       
    }

    function purchaseItem(uint _itemId,uint256 amount_of_purchase) public payable  {
        uint256 _totalPrice = getTotalPrice(_itemId,amount_of_purchase);
        total_pric = _totalPrice;
        Item storage item = items[_itemId];
        require(_itemId > 0 && _itemId <= itemCount, "item doesn't exist");
        uint256 msg_value = coin.balanceOf(msg.sender);
        require(msg_value >= _totalPrice, "not enough ether to cover item price and market fee");
        //       // pay seller and feeAccount
        address buyer  = msg.sender;
        uint256 item_price = item.price*amount_of_purchase;
        transferFrom(address(this), buyer, item.itemId, amount_of_purchase);
        item.amount-=amount_of_purchase;
        if (item.amount <=0) {
            item.amount =0;
        }
        feeGas = _totalPrice - item_price;
        coin.approve(buyer,add_coin ,_totalPrice);
        coin.transferFrom(buyer,item.seller , item_price );
        coin.transferFrom(buyer,feeAccount , _totalPrice - item_price);
    }
    function getTotalPrice(uint _itemId,uint256 amount_of_purchase) view public returns(uint256){
        return(((items[_itemId].price*(100 + feePercent))/100)*amount_of_purchase);
    }
    function transferFrom(address from,address to,uint256 id_,uint256 amount) internal  {
        // uint256 balanceOfStock = nft.balanceOf(from,id_ );
        // require(balanceOfStock>=amount,"loi o day ne");
        nft.allowance(from, add_nft , id_ ,amount );
        nft.transferFrom(from,to,id_,amount);

    }
}