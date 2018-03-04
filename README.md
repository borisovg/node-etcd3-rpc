# node-etcd-rpc

This module loads etcd3's `rpc.proto` file so that you can access the gRPC API from Node.
More importantly, it brings together all the other `.proto` files necessary to load it.

You can use this module as a client to etcd3, but you will probably want to wrap some code around it for more functionality (e.g. failover to other server instances).

See [rpc.proto](proto/rpc.proto) for more information.

## Installation

```
npm install etcd-rpc
```

## Example clients

See files in [examples/](examples/).
