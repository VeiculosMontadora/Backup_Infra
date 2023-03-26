# Passo Manual - Frontend e Banco de Dados

> O Terraform não é uma ferramenta de automação de deploys, mas sim de provisionamento de infraestrutura. Existem ferramentas especializadas para automação de deploys, como o Ansible, Chef, Puppet, etc, no entanto, acreditamos que o uso desses tipos de ferramenta está além do escopo do projeto.

Com isso dito, o deploy do frontend e do banco de dados na instância EC2 deve ser feito de forma manual.

## Instalação

1. No console da AWS da AGES, acesse a instância EC2 que foi provisionada pelo Terraform. Para isso, vá em **Services > EC2 > Instances** e selecione a instância.

2. Conecte-se na instância clicando em **Connect** e siga as instruções para conectar-se.

3. Crie um docker-compose.yaml definindo os serviços do frontend e do banco de dados. Nele referencie a imagem do frontend que está no ECR provisionado pelo Terraform. Para o banco de dados, use a imagem oficial do MongoDB.

```yaml
Docker Compose a ser feito...
```
