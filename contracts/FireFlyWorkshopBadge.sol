// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract FireFlyWorkshopBadge is ERC721, Pausable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    mapping(address => bool) private minted;
    mapping(address => bool) private received;

    constructor() ERC721("Hyperledger FireFly Workshop Participant - Global Forum 2022", "HGFFF2022"){
        _pause();
    }

    modifier onlyOnce(address to) {
        require(minted[msg.sender] == false, "You can only mint one token");
        require(received[to] == false, "You can only receive one token");
        _;
        minted[msg.sender] = true;
        received[to] = true;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/QmPE12GpZuEB2LL3aUqKZzTu2widAtwqSVY8L9f62AcUVm";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to) public whenNotPaused onlyOnce(to) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        _requireMinted(tokenId);
        return _baseURI();
    }
}
