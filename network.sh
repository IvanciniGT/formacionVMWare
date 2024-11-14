#!/bin/bash

function create_network {
  ansible-playbook Virtualswitch/playbook.yaml \
                --extra-vars "@Virtualswitch/variables.yaml" \
                --extra-vars "@config/connection.yaml" \
                --extra-vars "@config/secretos.yaml" \
                --extra-vars "state=present"
  ansible-playbook Network/playbook.yaml \
                --extra-vars "@Network/variables.yaml" \
                --extra-vars "@Virtualswitch/variables.yaml" \
                --extra-vars "@config/connection.yaml" \
                --extra-vars "@config/secretos.yaml" \
                --extra-vars "state=present"
}

function destroy_network {
  ansible-playbook Network/playbook.yaml \
                --extra-vars "@Network/variables.yaml" \
                --extra-vars "@Virtualswitch/variables.yaml" \
                --extra-vars "@config/connection.yaml" \
                --extra-vars "@config/secretos.yaml" \
                --extra-vars "state=absent"
  ansible-playbook Virtualswitch/playbook.yaml \
                --extra-vars "@Virtualswitch/variables.yaml" \
                --extra-vars "@config/connection.yaml" \
                --extra-vars "@config/secretos.yaml" \
                --extra-vars "state=absent"
}

[[ "$1" == "delete" ]] && destroy_network || create_network
