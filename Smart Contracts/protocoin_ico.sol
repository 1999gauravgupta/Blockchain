pragma solidity ^0.4.11;

contract protocoin_ico{
    uint public max_protocoin=1000000;
    uint public usd_to_protocoin=1000;
    uint public total_protocoin_bought=0;
    
    mapping(address=>uint) equity_protocoin;
    mapping(address=>uint) equity_usd;
    
    modifier can_buy_protocoin(uint usd_invested){
       require(usd_invested*usd_to_protocoin+total_protocoin_bought<=max_protocoin);
       _;
    }

    function equity_in_protocoin(address ivestor)external constant returns(uint){
        return equity_protocoin(investor);
    }
    
    function equity_in_usd(address ivestor)external constant returns(uint){
        return equity_usd(investor);
    }
    
    function buy_protocoin(address investor,uint usd_invested) external
    can_buy_protocoin(usd_invested){
        equity_protocoin[investor]+=usd_invested*usd_to_protocoin;
        equity_usd[investor]=equity_protocoin[investor]/usd_to_protocoin;
        total_protocoin_bought+=usd_invested*usd_to_protocoin;
    }
    
    function sell_protocoin(address investor,uint protocoins_sold) external{
        equity_protocoin[investor]-=protocoins_sold;
        equity_usd[investor]=equity_protocoin[investor]/usd_to_protocoin;
        total_protocoin_bought-=protocoins_sold;
    }
}
