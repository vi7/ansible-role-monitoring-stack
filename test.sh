#!/usr/bin/env bash

set -e

VENV_PRESENT=true

check_venv() {
  if [ -z "$VIRTUAL_ENV" ]
  then
    printf '\e[1;33m[WARN] Looks like Python virtualenv is deactivated. Trying to activate it automatically..\e[0m\n'
    export VENV_PRESENT=false
    virtualenv venv
    if ! source venv/bin/activate
    then
      printf "\e[1;31m[ERROR] Automatic virtualenv activation failed! Run 'virtualenv venv' manually and try again.\e[0m\n"
      exit 1
    fi
  fi
}

install_deps() {
  pip3 install --upgrade -r test-requirements.txt

  ## Uncomment to install Galaxy collections or roles
  # ansible-galaxy collection install -r requirements.yml
  # ansible-galaxy install -f -p roles -r requirements.yml
}

run_tests() {
  molecule lint
}

##############
##   MAIN   ##
##############
main() {
  check_venv
  install_deps

  if [ -f molecule/default/molecule.yml ]
  then
    run_tests
  else
    printf '\n\e[1;33m[WARN] Skipping tests due to Molecule not being configured for the role.
    Run "molecule init scenario -r my_role_name -d vagrant" command from within the role directory (e.g. my_role_name/).
    \e[0m\n'
  fi
}


main "$@"
