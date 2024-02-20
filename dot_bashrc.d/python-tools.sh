#!/bin/bash
export PATH=$PATH:$(find ~/.cache/pypoetry/virtualenvs/python-tools-* -maxdepth 0 | sed 's#$#/bin#' | paste -sd':')
