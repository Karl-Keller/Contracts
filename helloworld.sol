pragma solidity ^0.4.16;

contract helloWorld {

    string _contract;
    
    function helloWorld (string _p)  {
        _contract = _p;
    }

    function getContract () constant returns (string) {
        return _contract;
    }
    
    function setContract (string _p) constant public {
        _contract = _p;
    }
}