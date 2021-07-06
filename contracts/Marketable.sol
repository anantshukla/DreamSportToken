pragma solidity ^0.6.2;

// SPDX-License-Identifier: MIT License

import "./Context.sol";

contract Marketable is Context {
    address private _marketingWallet;

    event MarketingWalletTransferred(address indexed previousMarketingWallet, address indexed newMarketingWallet);

    /**
     * @dev Initializes the contract setting the deployer as the initial marketing wallet.
     */
    constructor () public {
        address msgSender = _msgSender();
        _marketingWallet = msgSender;
        emit MarketingWalletTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current marketing wallet.
     */
    function marketingWallet() public view returns (address) {
        return _marketingWallet;
    }

    /**
     * @dev Throws if called by any account other than the marketing wallet.
     */
    modifier onlyMarketingWallet() {
        require(_marketingWallet == _msgSender(), "Marketable: caller is not the current marketing wallet");
        _;
    }


    /**
     * @dev Transfers marketing wallet guardianship of the contract to a new account (`newMarketingWallet`).
     * Can only be called by the current marketing wallet.
     */
    function transferMarketingWalletGuardianship(address newMarketingWallet) public virtual onlyMarketingWallet {
        require(newMarketingWallet != address(0), "Marketable: new market wallet is the zero address");
        emit MarketingWalletTransferred(_marketingWallet, newMarketingWallet);
        _marketingWallet = newMarketingWallet;
    }
}