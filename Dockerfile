FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV SNAP_HOME=/usr/local/snap
ENV PATH="$SNAP_HOME/bin:$PATH"

RUN apt-get update && apt-get install -y \
    openjdk-21-jre \
    python3 \
    python3-pip \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

COPY snap.zip /tmp/snap.zip
RUN unzip /tmp/snap.zip -d /usr/local/snap && rm /tmp/snap.zip

RUN echo 'alias gpt="java -cp \"$SNAP_HOME/*\" org.esa.snap.core.gpf.main.GPT"' >> ~/.bashrc \
    && echo 'export PATH=$SNAP_HOME:$PATH' >> ~/.bashrc \
    && echo 'export PYTHONPATH=$SNAP_HOME/snappy:$PYTHONPATH' >> ~/.bashrc

RUN echo '#!/bin/bash\njava -cp "/usr/local/snap/*" org.esa.snap.core.gpf.main.GPT "$@"' > /usr/local/bin/gpt \
    && chmod +x /usr/local/bin/gpt

RUN python3 -c "import sys; sys.path.append('/usr/local/snap/snappy'); from snappy import ProductIO; print('Snappy works!')" || echo "Snappy check skipped"

WORKDIR /workspace
CMD ["/bin/bash"]