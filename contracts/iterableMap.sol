// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

library IterableMapping {
    struct Map {
        address[] keys;
        mapping(address => uint256) values;
        mapping(address => uint256) indexOf;
        mapping(address => bool) inserted;
    }

    function getValue(Map storage map, address key) public view returns(uint256) {
        return map.values[key];
    }

    function getKeyAtIndex(Map storage map, uint256 _index) public view returns(address) {
        return map.keys[_index];
    }

    function getSize(Map storage map) public view returns(uint256) {
        return map.keys.length;
    }

    function setMap(Map storage map, address key, uint256 value) public {
        if (map.inserted[key]) {
            map.values[key] = value;
        } else {
            map.keys.push(key);
            map.values[key] = value;
            map.indexOf[key] = map.keys.length-1;
            map.inserted[key] = true;
        }
    }

    function removeFromMap(Map storage map, address key) public {
        if (!map.inserted[key]) {
            return;
        }

        uint256 length = map.keys.length;
        uint256 index = map.indexOf[key];
        delete map.values[key];
        delete map.inserted[key];
        delete map.indexOf[key];

        address[] memory newKeys;
        newKeys = map.keys;

        for (uint256 i = index; i < length - 1; i++) {
            newKeys[i] = newKeys[i+1];
        }

        //console.log(newKeys.length);

        map.keys = newKeys;

        //console.log(newKeys.length);
        map.keys.pop();
    }
}

contract TestIterableMap {
    using IterableMapping for IterableMapping.Map;

    IterableMapping.Map private map;

    function testIterableMap() public {
        map.setMap(address(0), 0);
        map.setMap(address(1), 100);
        map.setMap(address(2), 200); // insert
        map.setMap(address(2), 200); // update
        map.setMap(address(3), 300);

        for (uint256 i = 0; i < map.keys.length; i++) {
            address key = map.keys[i];
            
            if (map.values[key] != i * 100) {
                revert("value is not correct.");
            }
        }

        map.removeFromMap(address(1));

        assert(map.getSize() == 3);
        assert(map.getKeyAtIndex(0) == address(0));
        assert(map.getKeyAtIndex(1) == address(2));
        assert(map.getKeyAtIndex(2) == address(3));
    }
}