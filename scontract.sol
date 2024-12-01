pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EMI1 is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("Emiru", "EMI") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }

    function mint(address account, uint256 amount) public onlyOwner {
        require(amount > 100, "Mint amount must be greater than 190 Emiru Token");
        assert(account != address(0));
        _mint(account, amount);
    }

    function burn(uint256 amount) public {
        require(amount > 0, "Burn amount must be greater than zero");
        require(amount <= balanceOf(msg.sender), "Insufficient balance to burn");

        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        require(to != address(0), "Transfer to the zero address");

        if (value > balanceOf(msg.sender)) {
            revert("Insufficient balance");
        }

        _transfer(_msgSender(), to, value);
        return true;
    }
}
