// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";

contract RoundRobin is ERC721("RoundRobin", "Robin") {
    using SafeMath for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _robinCounter;

    mapping(uint256 => uint256) RobinsToSuccessors;

    string[] private _successor = ["vitalik"];
    string private text;

    function createPlainRobin() external {
      uint256 _RobinId = _robinCounter.current();
      RobinsToSuccessors[_RobinId] = 0;
      // uint256 succcessorId = RobinsToSuccessors[_RobinId];
      RobinsToSuccessors[_RobinId] = RobinsToSuccessors[_RobinId].add(1);
      _safeMint(msg.sender, _RobinId);
      // signing(name);

      _robinCounter.increment();
    }

    function inherit(
      address to,
      uint256 robinId
    ) public {
      require(_exists(robinId),"robin of id is not exist");
      RobinsToSuccessors[robinId] = RobinsToSuccessors[robinId].add(1);
      _transfer(_msgSender(), to, robinId);
    }

    function signing(string memory name, uint256 successorId) public{
      // uint256 successorId = RobinsToSuccessors[_RobinId]; 
      string memory id = Strings.toString(successorId);
      string memory signature = string(
        abi.encodePacked(name, "#", id)
      );
      _successor.push(signature);
      uint256 textLength = _successor.length;
      for (uint256 i = 0; i < textLength; i++){
        text = string(
                abi.encodePacked(text,'<p>', _successor[i],'</p>')
            );
      }
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
      require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

      string memory svg = getSVG();
      bytes memory json = abi.encodePacked(
          '{"name": "RoundRobin #',
          Strings.toString(tokenId),
          '", "description": "RoundRobin is a full on-chain Robin.", "image": "data:image/svg+xml;base64,',
          Base64.encode(bytes(svg)),
          '"}'
      );
      return string(abi.encodePacked("data:application/json;base64,", Base64.encode(json)));
    }

    function getSVG() public view returns (string memory) {
      return string(abi.encodePacked(
        '<svg width="300" height="300" viewBox="0, 0, 300, 300" xmlns="http://www.w3.org/2000/svg">',
        '<rect width="100%" height="100%" fill="#f2eecb" />',
        '<foreignObject x="10" y="10" width="280" height="280">',
        '<div xmlns="http://www.w3.org/1999/xhtml" style="font-size:x-small;text-indent:1em">',
        text,
        '</div></foreignObject></svg>'
      ));
    }
}