FROM ubuntu:21.10

ENV PACKAGES="make build-essential git libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
TZ=Europe/London \
apt-get install --download-only -y ${PACKAGES}
RUN DEBIAN_FRONTEND=noninteractive \
TZ=Europe/London \
apt-get install -y ${PACKAGES}

ENV PYENV_ROOT=/pyenv
ENV PATH=${PYENV_ROOT}/bin:${PATH}
RUN git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT}

RUN eval "$(pyenv init --path)"
ENV CODE_ROOT=/code
RUN mkdir -p ${CODE_ROOT}
WORKDIR ${CODE_ROOT}
ENTRYPOINT pyenv install $(pyenv local) && cp -r /pyenv/versions/* ${CODE_ROOT}/pyenv_versions
VOLUME ${CODE_ROOT}
