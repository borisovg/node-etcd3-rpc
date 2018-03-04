/*jshint node:true, esversion:6*/
'use strict';

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
