# Deploy - GitLab Runner

1. No console da AWS da AGES, acesse a instância EC2 que foi provisionada pelo Terraform. Para isso, vá em **Services > EC2 > Instances** e selecione a instância.

2. Conecte-se na instância clicando em **Connect** e siga as instruções para conectar-se.

3. Crie um volume para armazenar os dados do GitLab Runner:

```bash
docker volume create gitlab-runner-config
```

4. Execute o seguinte comando para iniciar o contâiner do GitLab Runner:

```bash
docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:alpine3.15-v15.10.1
```

5. Execute o seguinte comando para registrar o GitLab Runner:

```bash
docker run --rm -it -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:alpine3.15-v15.10.1 register --name "Veículos Via Montadora GitLab Runner" --url "https://tools.ages.pucrs.br/" --docker-privileged true
```

Você será solicitado a inserir algumas informações, segue abaixo:

**URL:** https://tools.ages.pucrs.br/ (default, apenas pressione Enter)

**Registration Token:** (Copie o token do GitLab Runner que está no GitLab, em **Settings > CI/CD > Runners**)

**Description:** Veículos Via Montadora GitLab Runner (default, apenas pressione Enter)

**Tags:** Deixar vazio! (default, apenas pressione Enter)

**Optional Maintenance:** Deixar vazio! (default, apenas pressione Enter)

**Executor:** docker

**Docker Image:** alpine:3.15
