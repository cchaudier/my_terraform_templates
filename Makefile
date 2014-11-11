ansible_dir=ansible
tfvars_file=terraform.tfvars

.PHONY: all plan apply destroy

all: plan apply

plan:
	terraform plan -var-file $(tfvars_file) -out terraform.tfplan

apply:
	terraform apply -var-file $(tfvars_file)

destroy:
	terraform plan -destroy -var-file $(tfvars_file) -out terraform.tfplan
	terraform apply terraform.tfplan; terraform apply terraform.tfplan

refresh:
	terraform plan -refresh=true -var-file $(tfvars_file) -out terraform.tfplan
	terraform refresh terraform.tfplan
	terraform apply terraform.tfplan

status:
	terraform show terraform.tfstate

clean:
	rm -rf *.tfstate*
	rm -rf *.tfplan*
	rm -rf *.log

dev:
	ln -fs $@.tfvars $(tfvars_file)
	cd $(ansible_dir)/env_vars; ln -fs $@.yml spec.yml

staging:
	ln -fs $@.tfvars $(tfvars_file)
	cd $(ansible_dir)/env_vars; ln -fs $@.yml spec.yml

prod:
	ln -fs $@.tfvars $(tfvars_file)
	cd $(ansible_dir)/env_vars; ln -fs $@.yml spec.yml
