# node-etcd-rpc

This module loads etcd's `rpc.proto` file so that you can access the gRPC API from Node.
More importantly, it brings together all the pieces necessary to load that file.

You can use this module as a client to etcd, but you will probably want to wrap some code around it for more functionality (e.g. failover to other server instances).
