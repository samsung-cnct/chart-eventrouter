# Copyright 2017 Samsung SDS Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM alpine:3.8
LABEL MAINTAINER="OSS Maintainers <oss-maintainer@samsung-cnct.io>"

RUN apk update --no-cache && apk add ca-certificates \
  && apk --no-cache add --virtual .build-deps \
  go git libc-dev \
  && mkdir /go \
  && GOPATH=/go go get github.com/heptiolabs/eventrouter \
  && cp /go/bin/eventrouter /usr/local/bin/ \
  && mkdir /etc/eventrouter \
  && rm -rf /go \
  && apk del .build-deps

COPY config.json /etc/eventrouter/

USER nobody:nobody
CMD ["/bin/sh", "-c", "/usr/local/bin/eventrouter -v 3 -logtostderr"]
