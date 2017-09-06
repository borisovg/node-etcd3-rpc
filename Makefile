PROTO = proto/rpc.proto \
        proto/gogoproto/gogo.proto \
        proto/etcd/mvcc/mvccpb/kv.proto \
        proto/etcd/mvcc/mvccpb/gogoproto/gogo.proto \
        proto/etcd/auth/authpb/auth.proto \
        proto/etcd/auth/authpb/gogoproto/gogo.proto \
        proto/google/api/annotations.proto \
        proto/google/api/google/api/http.proto

.PHONY: all
all: proto

## clean: remove all .proto files
.PHONY: clean
clean:
	rm -rf proto

proto/rpc.proto: submodules/etcd/etcdserver/etcdserverpb/rpc.proto
	mkdir -p $(@D)
	cp $< $@

proto/gogoproto/gogo.proto: submodules/protobuf/gogoproto/gogo.proto
	mkdir -p $(@D)
	cp $< $@

proto/etcd/mvcc/mvccpb/kv.proto: submodules/etcd/mvcc/mvccpb/kv.proto
	mkdir -p $(@D)
	cp $< $@

proto/etcd/mvcc/mvccpb/gogoproto/gogo.proto: submodules/protobuf/gogoproto/gogo.proto
	mkdir -p $(@D)
	cp $< $@

proto/etcd/auth/authpb/auth.proto: submodules/etcd/auth/authpb/auth.proto
	mkdir -p $(@D)
	cp $< $@

proto/etcd/auth/authpb/gogoproto/gogo.proto: submodules/protobuf/gogoproto/gogo.proto
	mkdir -p $(@D)
	cp $< $@

proto/google/api/annotations.proto: submodules/googleapis/google/api/annotations.proto
	mkdir -p $(@D)
	cp $< $@

proto/google/api/google/api/http.proto: submodules/googleapis/google/api/http.proto
	mkdir -p $(@D)
	cp $< $@

## proto: update .proto files (default)
proto: $(PROTO)

.PHONY: help
help:
	@sed -n 's/^##//p' Makefile
