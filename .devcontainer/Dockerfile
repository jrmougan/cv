FROM texlive/texlive:latest

RUN apt-get update && apt-get install -y openssh-client

# Crear workspace y asegurarte de que el usuario texlive tiene permisos
RUN mkdir -p /workspace \
    && chown texlive:texlive /workspace

USER texlive
WORKDIR /workspace
