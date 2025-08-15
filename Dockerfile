ARG DEBIAN_RELEASE
FROM python:3.12-slim-${DEBIAN_RELEASE}

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    ca-certificates \
    time \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir nltk

# run the downloader during image build (this is the step that is slow under qemu)
RUN time python3 -W ignore::RuntimeWarning -m nltk.downloader -d "/usr/share/nltk_data" snowball_data
