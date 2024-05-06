#!/bin/bash
# tasks.yml hash: {{ include "dot_ansible/roles/kahowell-laptop/tasks/main.yml" | sha256sum }
echo "Running ansible w/ kahowell-laptop role"
ansible -K localhost -m include_role -a name=kahowell-laptop
