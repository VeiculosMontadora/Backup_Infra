# Passo Manual - Deploy de Serviços

> O Terraform não é uma ferramenta de automação de deploys, mas sim de provisionamento de infraestrutura. Existem ferramentas especializadas para automação de deploys, como o Ansible, Chef, Puppet, etc, no entanto, acreditamos que o uso desses tipos de ferramenta está além do escopo do projeto.

Com isso dito, o deploy de nossos serviços na instância EC2 deve ser feito de forma manual. Os serviços que irão ser executados na instância são:

- Frontend (React.js)
- Banco de Dados (MongoDB)
- GitLab Runner

Nas pastas `frontend-and-database` e `gitlab-runner` deste diretório, você encontrará um `README.md` com as instruções para o deploy de cada serviço.
