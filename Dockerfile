FROM apache/airflow:2.4.2-python3.10

USER root
RUN echo "airflow ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  mv /etc/apt/sources.list.d/*.list /tmp && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    curl \
    dumb-init \
    gcc \
    git \
    gosu \
    libaio1 \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    openssl \
    procps \
    python-dev \
    unzip \
    vim \
    wget \
    ca-certificates && \
  apt-get clean && rm -rf /var/lib/apt/lists/* && \
  update-ca-certificates && \
  curl -L "https://github.com/tsl0922/ttyd/releases/download/1.7.2/ttyd.x86_64" -o /usr/bin/ttyd && \
  chmod +x /usr/bin/ttyd

USER airflow

COPY --chown=airflow:0 ./requirements.txt /tmp/requirements.txt

RUN pip3 install --no-build-isolation "Cython<3" "pyyaml==5.4.1" && \
  pip3 install --no-cache-dir --user --requirement /tmp/requirements.txt
