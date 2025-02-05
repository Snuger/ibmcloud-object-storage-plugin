FROM golang:1.16.10

# Default values
ARG git_commit_id=unknown
ARG build_date=unknown

WORKDIR /go/src/github.com/IBM/ibmcloud-object-storage-plugin
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN go env -w GO111MODULE=on
ADD . /go/src/github.com/IBM/ibmcloud-object-storage-plugin
RUN set -ex; cd /go/src/github.com/IBM/ibmcloud-object-storage-plugin/ && CGO_ENABLED=0 go install -mod=mod -v -ldflags "-X main.Version=${git_commit_id} -X main.Build=${build_date}" github.com/IBM/ibmcloud-object-storage-plugin/cmd/driver
CMD ["/bin/bash"]
