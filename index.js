/*jshint node:true*/
'use strict';

var grpc = require('grpc');
var proto = grpc.load(__dirname + '/proto/rpc.proto');

module.exports = proto.etcdserverpb;
