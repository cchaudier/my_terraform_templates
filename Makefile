.PHONY: all plan apply destroy

all: plan apply

plan:
	terraform plan -var-file terraform.tfvars -out terraform.tfplan

apply:
	terraform apply -var-file terraform.tfvars

destroy:
	terraform plan -destroy -var-file terraform.tfvars -out terraform.tfplan
	terraform apply terraform.tfplan; terraform apply terraform.tfplan

refresh:
	terraform plan -refresh=true -var-file terraform.tfvars -out terraform.tfplan
	terraform refresh terraform.tfplan
	terraform apply terraform.tfplan

status:
	terraform show terraform.tfstate

clean:
	rm -rf *.tfstate*
	rm -rf *.log
