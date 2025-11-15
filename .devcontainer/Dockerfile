FROM texlive/texlive:latest

# Crear workspace y asegurarte de que el usuario texlive tiene permisos
RUN mkdir -p /workspace \
    && chown texlive:texlive /workspace

USER texlive
WORKDIR /workspace
