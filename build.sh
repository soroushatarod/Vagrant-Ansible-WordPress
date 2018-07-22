#!/bin/sh
cd provisioning/roles
ansible-playbook apache/tests/test.yml --syntax-check