<div align="center">
  <img src="resources/AvalancheLogoRed.png?raw=true">
</div>

# ava-sim
`ava-sim` makes it easy for anyone to spin up a local instance of an Avalanche network
to interact with the [standard APIs](https://docs.avax.network/build/avalanchego-apis)
or to test a [custom
VM](https://docs.avax.network/build/tutorials/platform/create-custom-blockchain).

### Prerequisites
You must have [Golang](https://golang.org/doc/install) >= `1.16` and a configured
[`$GOPATH`](https://github.com/golang/go/wiki/SettingGOPATH).

## Standard Network
To spin up a standard 5 node network, just run `./scripts/run.sh`. When the
network is running, you'll see the following logs printed:
```txt
standard VM endpoints now accessible at:
NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg: http://127.0.0.1:9650
NodeID-MFrZFVCXPv5iCn6M9K6XduxGTYp891xXZ: http://127.0.0.1:9652
NodeID-NFBbbJ4qCmNaCzeW7sxErhvWqvEQMnYcN: http://127.0.0.1:9654
NodeID-GWPcbFJZFfZreETSoWjPimr846mXEKCtu: http://127.0.0.1:9656
NodeID-P7oB2McjBGgW2NXXWVYjV8JEDFoW9xDE5: http://127.0.0.1:9658
```

## Custom VM (Subnet)
_Before running your own VM, we highly recommend reading the [Create a Custom
Blockchain Tutorial](https://docs.avax.network/build/tutorials/platform/create-custom-blockchain).
This tool automates all the steps here so running your own VM is just a single command._

To spin up a 5 node network where all nodes run your custom VM, just run `./scripts/run.sh [vm] [vm-genesis]`.
In this command, `[vm]` is the path to your custom VM binary and `[vm-genesis]`
is the path to your custom VM genesis. You can learn more about writing your
own VM
[here](https://docs.avax.network/build/tutorials/platform/create-a-virtual-machine-vm).

### Example: [TimestampVM](https://github.com/ava-labs/timestampvm)
For those that have yet to create their own VM, you can run `./scripts/timestampvm.sh` to start your own network + subnet running the `TimestampVM`. After initial network startup,
you'll see the following logs when all validators in the network are validating
your custom blockchain (the actual blockchain ID may be slightly different):
```txt
NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg validating blockchain 28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
NodeID-MFrZFVCXPv5iCn6M9K6XduxGTYp891xXZ validating blockchain 28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
NodeID-NFBbbJ4qCmNaCzeW7sxErhvWqvEQMnYcN validating blockchain 28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
NodeID-GWPcbFJZFfZreETSoWjPimr846mXEKCtu validating blockchain 28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
NodeID-P7oB2McjBGgW2NXXWVYjV8JEDFoW9xDE5 validating blockchain 28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
```

When the VM is ready to interact with, the URLs it is accessible on will be
printed out:
```txt
Custom VM endpoints now accessible at:
NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg: http://127.0.0.1:9650/ext/bc/28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
NodeID-MFrZFVCXPv5iCn6M9K6XduxGTYp891xXZ: http://127.0.0.1:9652/ext/bc/28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
NodeID-NFBbbJ4qCmNaCzeW7sxErhvWqvEQMnYcN: http://127.0.0.1:9654/ext/bc/28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
NodeID-GWPcbFJZFfZreETSoWjPimr846mXEKCtu: http://127.0.0.1:9656/ext/bc/28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
NodeID-P7oB2McjBGgW2NXXWVYjV8JEDFoW9xDE5: http://127.0.0.1:9658/ext/bc/28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
```

You can view a full list of simple methods you can use to interact with the
custom VM [here](https://docs.avax.network/build/tutorials/platform/create-custom-blockchain#interact-with-the-new-blockchain). Getting the genesis block is a good starter:
```txt
curl -X POST --data '{
    "jsonrpc": "2.0",
    "method": "timestampvm.getBlock",
    "params":{
        "id":""
    },
    "id": 1
}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/bc/28TtJ7sdYvdgfj1CcXo5o3yXFMhKLrv4FQC9WhgSHgY6YNYRs2
```

## What this is NOT
This tool is **NOT** intended to be a full-fledged node automation framework.
Rather, it is meant to be a simple tool for anyone to get started with
Avalanche.

If you are looking for a more powerful framework, check out [avash](https://github.com/ava-labs/avash). This tool lets
you run multiple versions of the same binary and provide custom node configs.

## TODOs
- [ ] Cleanup node initialization (should be able to init directly instead of needing to convert from flags to
  config)
