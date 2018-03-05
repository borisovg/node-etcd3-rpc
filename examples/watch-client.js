/*jshint node:true, esversion:6*/
'use strict';

const grpc = require('grpc');
const etcd = require('etcd3-rpc');

const client = new etcd.Watch('localhost:2379', grpc.credentials.createInsecure());
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

    setTimeout(function () {
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
