#!/bin/bash

source "./lib/install_helper.sh"
announce "Python Tools"
require_function python3
require_function pip3

pip3 install --upgrade pip || fail "could not update pip"
pip3 install --upgrade pre-commit || fail "could not install pre-commit"
pip3 install --upgrade awscli || fail "could not install awscli"
pip3 install --upgrade glances || fail "could not install glances"
pip3 install --upgrade asciinema || fail "could not install asciinema"
pip3 install --upgrade virtualenv || fail "could not install virtualenv"