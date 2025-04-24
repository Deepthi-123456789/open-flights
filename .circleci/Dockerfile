FROM alpine:3.18
LABEL maintainer="CircleCI <        
https://circleci.com/>"
LABEL org.opencontainers.image.authors="CircleCI <https://circleci.com/>"
LABEL org.opencontainers.image.url="https://circleci.com/"
WORKDIR /opt/circleci
COPY . /opt/circleci
RUN apk add --no-cache --update \
    bash \
    curl \
    git \
    jq \
    python3 \
    python3-dev \
    py3-pip \
    py3-setuptools \
    py3-wheel \
    py3-virtualenv \
    libffi-dev \
    musl-dev \
    openssl-dev && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade setuptools && \
    pip3 install --upgrade wheel && \
    pip3 install --upgrade virtualenv && \
    rm -rf /var/cache/apk/* /tmp/* /root/.cache
RUN virtualenv -p python3 /opt/circleci/venv && \
    /opt/circleci/venv/bin/pip install --upgrade pip && \
    /opt/circleci/venv/bin/pip install --upgrade setuptools && \
    /opt/circleci/venv/bin/pip install --upgrade wheel && \
    /opt/circleci/venv/bin/pip install --upgrade virtualenv && \
    /opt/circleci/venv/bin/pip install --upgrade -r requirements.txt && \
    rm -rf /var/cache/apk/* /tmp/* /root/.cache
ENV PATH="/opt/circleci/venv/bin:$PATH" \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8
ENV CIRCLECI=true
ENV CIRCLE_ARTIFACTS=/opt/circleci/artifacts
ENV CIRCLE_TEST_REPORTS=/opt/circleci/test-reports
COPY . .
RUN chmod +x /opt/circleci/venv/bin/* && \
    chmod +x /opt/circleci/scripts/* && \
    chmod +x /opt/circleci/bin/* && \
    chmod +x /opt/circleci/venv/bin/* && \
    chmod +x /opt/circleci/venv/bin/entrypoint.sh && \
    chmod +x /opt/circleci/venv/bin/run.sh
ENTRYPOINT ["/opt/circleci/venv/bin/entrypoint.sh"]
EXPOSE 8080
CMD ["bash", "-c", "/opt/circleci/venv/bin/run.sh"]




# Build the Docker image
# docker build -t circleci-docker-image:latest .
# Run the Docker container
