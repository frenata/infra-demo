SERVER_ADMIN ?= ubuntu
SSH_PUB_KEY  ?= ~/.ssh/sample.pub
SSH_PRIV_KEY  ?= ~/.ssh/sample

init:
	cd terraform && terraform init
	cd ansible && ansible-galaxy install -r requirements.yaml

check:
	cd terraform && terraform plan -var="server_admin=${SERVER_ADMIN}" -var="ssh_key_path=${SSH_PUB_KEY}"

build:
	cd terraform && terraform apply -var="server_admin=${SERVER_ADMIN}" -var="ssh_key_path=${SSH_PUB_KEY}" -auto-approve

destroy:
	cd terraform && terraform destroy -var="server_admin=${SERVER_ADMIN}" -var="ssh_key_path=${SSH_PUB_KEY}" -auto-approve

ping:
	cd ansible && ansible all -i aws_ec2.yaml -u ${SERVER_ADMIN} --private-key ${SSH_PRIV_KEY} -m ping

ssh:
	cd terraform && ssh -i ${SSH_PRIV_KEY} ${SERVER_ADMIN}@`terraform output --json | jq -r .pip.value`

install:
	cd ansible && ansible-playbook playbook.yaml -i aws_ec2.yaml -u ${SERVER_ADMIN} --private-key ${SSH_PRIV_KEY}

inventory:
	cd ansible && ansible-inventory -i aws_ec2.yaml --graph
