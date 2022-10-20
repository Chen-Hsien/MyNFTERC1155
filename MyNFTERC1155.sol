// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/presets/ERC1155PresetMinterPauser.sol";


contract myNFT1155 is ERC1155PresetMinterPauser {
    
    uint256 public constant COMMON = 0;
    uint256 public constant RARE = 1;
    uint256 public constant SR = 2;
    uint256 public constant SSR = 3;
    
    constructor() ERC1155PresetMinterPauser( "https://gateway.pinata.cloud/ipfs/QmRoENYamuX58oHPRaCeAsPPxY5Mdk5NS4dwEkTbJoo8Hj/{id}") {
        _mint(msg.sender, COMMON, 10**18, "");
        _mint(msg.sender, SSR, 1, "");
        _mint(msg.sender, RARE, 5, "");
        _mint(msg.sender, SR, 10, "");
    }
    
}
