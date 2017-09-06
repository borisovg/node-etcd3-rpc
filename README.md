# node-etcd-rpc

This module loads etcd's `rpc.proto` file so that you can access the gRPC API from Node.
More importantly, it brings together all the pieces necessary to load that file.

You can use this module as a client to etcd, but you will probably want to wrap some code around it for more functionality (e.g. failover to other server instances).

## Usage

```
npm install etcd-rpc grpc
```

Example client:

```
var grpc = require('grpc');
var etcd = require('etcd-rpc');
var client = new etcd.KV('etcd.server.hostname:2379', grpc.credentials.createInsecure());

client.put({
    key: new Buffer('foo'),
    value: new Buffer('foofoo'),
}, function (err) {
    if (err) {
        console.log('Error:', err);
    }
});

client.range({
    key: new Buffer('foo'),
}, function (err, res) {
    if (err) {
        console.log('Error:', err);
    } else {
        res.kvs.forEach(function (o) {
            console.log(o.key.toString(), '->', o.value.toString());
        });
    }
});
```

See [rpc.proto](proto/rpc.proto) for more information.
