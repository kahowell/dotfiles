#!/bin/bash
echo "Running ansible w/ kahowell-laptop role"
ansible -K localhost -m include_role -a name=kahowell-laptop
