# node-etcd-rpc

This module loads etcd's `rpc.proto` file so that you can access the gRPC API from Node.
More importantly, it brings together all the other `.proto` files necessary to load it.

You can use this module as a client to etcd, but you will probably want to wrap some code around it for more functionality (e.g. failover to other server instances).

## Usage

```
npm install etcd-rpc grpc
```

Example client:

```
const grpc = require('grpc');
const etcd = require('etcd-rpc');

const client = new etcd.KV('etcd.server.hostname:2379', grpc.credentials.createInsecure());

client.put({
    key: new Buffer('foo'),
    value: new Buffer('foofoo'),
}, function (err) {
    if (err) {
        throw err;
    }
});

client.range({
    key: new Buffer('foo'),
}, function (err, res) {
    if (err) {
        throw err;
    }

    res.kvs.forEach(function (o) {
        console.log(o.key.toString(), '->', o.value.toString());
    });
});
```

Example watcher client:

```
const grpc = require('grpc');
const etcd = require('etcd-rpc');

const client = new etcd.Watch('etcd.server.hostname:2379', grpc.credentials.createInsecure());
const stream = client.watch();

stream.on('data', function (data) {
    const id = data.watch_id;

    console.log('Created:', data);
    stream.removeAllListeners('data');

    stream.on('data', function (data) {
        data.events.forEach(function (ev) {
            console.log([ev.type, ev.kv.key.toString(), ev.kv.value.toString()]);
        });
    });

    setTimeout(function() {
        stream.on('data', function (data) {
            console.log('Cancelled:', data);
            stream.end();
        });

        stream.write({ cancel_request: { watch_id: id } });
    }, 10000);
});

stream.on('error', function (err) {
    throw err;
});

const ALL = new Buffer('\0');

stream.write({ create_request: { key: ALL, range_end: ALL } });
```

See [rpc.proto](proto/rpc.proto) for more information.
