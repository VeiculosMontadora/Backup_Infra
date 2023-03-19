# Infraestrutura

Esse é o repositório de infraestrutura do projeto Veículos Via Montadora. Ele é responsável por gerenciar a infraestrutura do projeto, provisionando Lambda Functions, EC2, S3, etc na AWS.

## Como funciona

O projeto utiliza o [Terraform](https://www.terraform.io/) para provisionar recursos na AWS. O Terraform é um software de provisionamento de infraestrutura como código, que permite que você crie, altere e versione a infraestrutura de forma segura e eficiente. O Terraform pode gerenciar provedores de serviços como AWS, Google Cloud, Azure, etc.

<br />
<img src="./wiki/images/terraform-logo.png" height="100" align="center" />
<br />
<br />
<br />

Além disso, o projeto também faz uso da ferramenta [Terragrunt](https://terragrunt.gruntwork.io/), que é uma ferramenta de linha de comando para o Terraform que fornece vários níveis de abstração com o objetivo de manter os arquivos de configuração do Terraform DRY (Don't Repeat Yourself). O Terragrunt pode provisionar recursos de vários módulos Terraform, permitindo que você crie uma hierarquia de módulos Terraform e reutilize o código. Além disso, ele gerencia automaticamente o estado do Terraform de forma remota, permitindo que várias pessoas trabalhem no mesmo projeto.

<img src="./wiki/images/terragrunt-logo.png" height="200" align="center" />
<br />

## Fluxo de Pipelines

Esse repositório possui pipelines que são responsáveis por provisionar os recursos na AWS. O fluxo de pipelines é o seguinte:

### Merge Request Aberto de `branch_customizada` ➜ `develop` 

Ao abrir um Merge Request de uma branch customizada para a branch `develop`, um pipeline será executado para realizar o plano de provisionamento dos recursos na AWS. Esse pipeline é responsável por validar se o código está correto e se os recursos serão provisionados corretamente. Caso o pipeline seja executado com sucesso, o Merge Request pode ser realizado e o código será mesclado com a branch `develop`.

### Merge Request Aberto de `develop` ➜ `master`

Esse é o mesmo fluxo do Merge Request acima, o planejamento dos recursos na AWS é realizado para garantir que o código está correto e que os recursos serão provisionados corretamente quando o Merge Request for realizado.

### Merge Request Realizado de `develop` ➜ `master`

Ao realizar o Merge Request de `develop` ➜ `master`, um pipeline será executado para realizar de fato o provisionamento dos recursos na AWS.
