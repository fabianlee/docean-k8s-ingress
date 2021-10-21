#!/bin/bash

declare -a menu_items=(
"Install Ansible dependencies"
"Use templates to generate files"
"Invoke Terraform to create k8s cluster"
"Ansible ssh ping on jumpbox"
"Local kubectl check on cluster"
"Apply roles to Droplet"
)

function show_menu() {

  echo ""
  echo "================================="
  echo " MENU"
  echo "================================="
  while [ ${#padding} -lt 50 ]; do padding=".$padding"; done
  COUNTER=1
  for item in "${menu_items[@]}"; do
    printf "%s%s %s\n" "$item" "${padding:${#item}}" "$COUNTER"
    ((COUNTER++))
  done

}

function check_prereq() {
  [ -n "${DO_PAT}" ] || { echo "ERROR must first define env var 'DO_PAT' with digital ocean personal token"; exit 3; }

  thepath=$(which terraform)
  [ -n "$thepath" ] || { echo "ERROR terraform 14+ needs to be installed. Run prereq/install_terraform.sh"; exit 3; }

  thepath=$(which ansible)
  [ -n "$thepath" ] || { echo "ERROR ansible 2.9+ needs to be installed. Run prereq/install_ansible_ppa.sh"; exit 3; }

  thepath=$(which doctl)
  [ -n "$thepath" ] || { echo "ERROR doctl needs to be installed. Run prereq/install_doctl.sh"; exit 3; }

  thepath=$(which helm)
  [ -n "$thepath" ] || { echo "ERROR helm needs to be installed. Run prereq/install_helm3_apt.sh"; exit 3; }

  thepath=$(which kubectl)
  [ -n "$thepath" ] || { echo "ERROR kubectl needs to be installed.  Run prereq/install_kubectl_apt.sh"; exit 3; }
}


############## MAIN #####################


check_prereq

answer=""
while [[ $answer != "q" ]]; do
  show_menu
  echo ""
  read -p "Enter number (1-${#menu_items[@]}, q to quit): " answer

  case $answer in
  1)
    ansible-playbook install_dependencies.yml
    ;;
  2)
    ansible-playbook playbook_generate_files.yml
    ;;
  3)
    cd tf
    make
    cd ..
    ;;
  4)
    ansible -m ping jumpbox
    ;;
  5)
    kubectl --kubeconfig=kubeconfig get nodes
    ;;
  6)
    ansible-playbook playbook_jumpbox.yml --extra-vars "DO_PAT=${DO_PAT}"
    ;;
  q)
    exit 0
    ;;
  *)
    echo "ERROR did not recognize menu choice '$answer'"
    ;;
  esac

 
  echo "" 
  read -p "Press <ENTER> to continue..."

done
