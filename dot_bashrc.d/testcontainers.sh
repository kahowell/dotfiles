export DOCKER_HOST=unix:///run/user/$(id -u)/podman/podman.sock
export TESTCONTAINERS_RYUK_DISABLED=true
export TESTCONTAINERS_CHECKS_DISABLE=true
