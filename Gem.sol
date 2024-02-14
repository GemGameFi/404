//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./ERC404.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Gem is ERC404 {
    string public dataURI;
    string public baseTokenURI;

    constructor(
        address _owner
    ) ERC404("Gem", "GEM", 18, 10000, _owner) {
        balanceOf[_owner] = 10000 * 10 ** 18;
        setWhitelist(_owner, true);
    }

    function setDataURI(string memory _dataURI) public onlyOwner {
        dataURI = _dataURI;
    }

    function setTokenURI(string memory _tokenURI) public onlyOwner {
        baseTokenURI = _tokenURI;
    }

    function setNameSymbol(
        string memory _name,
        string memory _symbol
    ) public onlyOwner {
        _setNameSymbol(_name, _symbol);
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        if (bytes(baseTokenURI).length > 0) {
            return string.concat(baseTokenURI, Strings.toString(id));
        } else {
            uint8 seed = uint8(bytes1(keccak256(abi.encodePacked(id))));
            string memory image;
            string memory color;

            if (seed <= 13) {
                image = "gold_gem.gif";
                color = "Gold";
            } else if (seed <= 34) {
                image = "color_gem.gif";
                color = "Color";
            } else if (seed <= 59) {
                image = "diamond_gem.gif";
                color = "Diamond";
            } else if (seed <= 92) {
                image = "blue&red_gem.gif";
                color = "Blue&Red";
            }  else if (seed <= 130) {
                image = "green_gem.gif";
                color = "Green";
            }  else if (seed <= 171) {
                image = "purple_gem.gif";
                color = "Purple";
            }  else if (seed <= 212) {
                image = "red_gem.gif";
                color = "Red";
            } else if (seed <= 255) {
                image = "black_gem.gif";
                color = "Black";
            }

            string memory jsonPreImage = string.concat(
                string.concat(
                    string.concat('{"name": "Gem #', Strings.toString(id)),
                    '","description":"A collection of 10,000 Replicants enabled by ERC404, a GameFi&SocialFi experimental token standard.","external_url":"https://gem.systems","image":"'
                ),
                string.concat(dataURI, image)
            );
            string memory jsonPostImage = string.concat(
                '","attributes":[{"trait_type":"Color","value":"',
                color
            );
            string memory jsonPostTraits = '"}]}';

            return
                string.concat(
                    "data:application/json;utf8,",
                    string.concat(
                        string.concat(jsonPreImage, jsonPostImage),
                        jsonPostTraits
                    )
                );
        }
    }
}