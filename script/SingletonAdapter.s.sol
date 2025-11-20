// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
 
import {Script, console} from "forge-std/Script.sol";
import {MorphoMarketV1SingletonAdapter} from "../src/adapters/MorphoMarketV1SingletonAdapter.sol";
import { VaultV2 } from "src/VaultV2.sol";
 
contract MorphoMarketV1SingletonAdapterScript is Script {
 
    function run() public {
        vm.startBroadcast();

        VaultV2 vault = VaultV2(0xC684eF73A0522046C6F5b4d9db42012e623EBCc1);
        address adapter = 0x5c6456672F488cef46357AA1FA611CC97017C55c;

        address owner = 0xB5ea370779Ec64a2E7d68640f7457249d7cf7eB7;

        vault.setCurator(owner);

        bytes memory setIsAllocatorCalldata = abi.encodeWithSelector(VaultV2.setIsAllo, adapter);

        bytes[] memory data = new bytes[](2);
        data[0] = abi.encodeWithSelector(VaultV2.submit.selector, setIsAllocatorCalldata);
        data[1] = setIsAllocatorCalldata;

        vault.multicall(data);
 
        vm.stopBroadcast();
    }
}