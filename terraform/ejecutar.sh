# Instalar terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
terraform -help

# Inicializa Terraform:
terraform init

# Planifica la ejecución:
terraform plan -var-file=datos.tfvars -var-file=conexion.tfvars

# Aplica los cambios:
terraform apply -var-file=datos.tfvars -var-file=conexion.tfvars

# Eliimina todo
terraform destroy -var-file=datos.tfvars -var-file=conexion.tfvars
