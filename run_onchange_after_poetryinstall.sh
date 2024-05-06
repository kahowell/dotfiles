#!/bin/bash
# poetry lock hash: {{ include "tools/python/poetry.lock" | sha256sum }}
cd ~/tools/python
poetry install --no-root --sync
