THISDIR := $(notdir $(CURDIR))
PROJECT := $(THISDIR)
TF := terraform

apply: init
	[ -n "${DO_PAT}" ] || { echo "ERROR must define env var DO_PAT with digital ocean personal token"; exit 3; }
	$(TF) apply --var "do_token=${DO_PAT}" -auto-approve

init: create-keypair
	$(TF) init

destroy:
	$(TF) destroy -var "do_token=${DO_PAT}" -auto-approve
	#./clean-known-hosts.sh
	#rm terraform.tfstate*

## create public/private keypair for ssh
create-keypair:
	# skips if file already exists
	[ -f id_rsa ] || ssh-keygen -t rsa -b 4096 -f id_rsa -C $(PROJECT) -N "" -q

refresh:
	$(TF) refresh -var "do_token=${DO_PAT}"
