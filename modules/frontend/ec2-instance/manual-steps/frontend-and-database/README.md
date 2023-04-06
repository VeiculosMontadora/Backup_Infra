# Deploy - Frontend e Banco de Dados

1. No console da AWS da AGES, acesse a instância EC2 que foi provisionada pelo Terraform. Para isso, vá em **Services > EC2 > Instances** e selecione a instância.

2. Conecte-se na instância clicando em **Connect** e siga as instruções para conectar-se.

3. Crie um docker-compose.yaml definindo os serviços do frontend e do banco de dados. Nele referencie a imagem do frontend que está no ECR provisionado pelo Terraform. Para o banco de dados, use a imagem oficial do MongoDB.

```yaml
version: "3.8"
services:
  # Frontend.
  frontend:
    image: <ECR_URL>:<TAG> # Use a imagem que está no ECR provisionado pelo Terraform aqui.
    ports:
      - "3000:3000"
  # MongoDB (Database).
  mongodb:
    image: mongo:6
    container_name: veiculos-via-montadora-mongodb
    restart: unless-stopped
    environment:
      MONGO_INITDB_ROOT_USERNAME: mongo_user
      MONGO_INITDB_ROOT_PASSWORD: mongo_password
    ports:
      - "27017:27017"
    volumes:
      - mongodb_data:/data/db
# Volumes.
volumes:
  mongodb_data:
    external: false
```

4. Execute o seguinte comando para iniciar os serviços:

```bash
docker-compose up -d
```
