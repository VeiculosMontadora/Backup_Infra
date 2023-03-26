# Passo Manual - GitLab Runners

Os GitLab Runners são responsáveis por executar os jobs do GitLab CI/CD. Eles são instalados em cada servidor que irá executar os jobs. Para este projeto, os runners serão instalados na instância EC2 que é provisionada pelo Terraform.

> O Terraform não é uma ferramenta de automação de deploys, mas sim de provisionamento de infraestrutura. Existem ferramentas especializadas para automação de deploys, como o Ansible, Chef, Puppet, etc, no entanto, acreditamos que o uso desses tipos de ferramenta está além do escopo do projeto.

Com isso dito, a instalação dos runners do GitLab na instância EC2 deve ser feita de forma manual.

## Instalação

1. No console da AWS da AGES, acesse a instância EC2 que foi provisionada pelo Terraform. Para isso, vá em **Services > EC2 > Instances** e selecione a instância.

2. Conecte-se na instância clicando em **Connect** e siga as instruções para conectar-se.

3. Execute os seguintes comandos para configurar os runners do GitLab:

```bash
# Faça o download do executável do GitLab Runner.
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Dê permissão de execução ao executável.
sudo chmod +x /usr/local/bin/gitlab-runner

# Crie um usuário para executar o GitLab Runner.
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Instale e inicie o GitLab Runner.
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start

# Registre o runner no GitLab.
# O token de registro pode ser obtido no console do GitLab, em Settings > CI/CD > Runners.
# Substitua o valor da variável REGISTRATION_TOKEN pelo token de registro.
sudo gitlab-runner register --url https://tools.ages.pucrs.br/ --registration-token $REGISTRATION_TOKEN
```
