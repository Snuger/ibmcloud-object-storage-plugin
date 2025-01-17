FROM golang:1.16.10
ADD . /go/src/github.com/IBM/ibmcloud-object-storage-plugin
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN go env -w GO111MODULE=on
RUN set -ex; cd /go/src/github.com/IBM/ibmcloud-object-storage-plugin/ && CGO_ENABLED=0 go install -mod=mod -v github.com/IBM/ibmcloud-object-storage-plugin/cmd/provisioner
RUN set -ex; tar cvC / ./etc/ssl  | gzip -n > /root/ca-certs.tar.gz
RUN set -ex; tar cvC /go/ ./bin | gzip -9 > /root/provisioner.tar.gz
