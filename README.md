# Golang Migrate - Teste de Migrações com Categories e Courses

Este projeto é um teste prático usando [golang-migrate/migrate](https://github.com/golang-migrate/migrate) para aplicar migrações `up` e `down` em um banco de dados relacional, container Mysql.

---

## 📦 Instalação do migrate

**Recomendado (binário direto):**

```bash
curl -L https://github.com/golang-migrate/migrate/releases/download/v4.17.0/migrate.linux-amd64.tar.gz | tar xvz
sudo mv migrate /usr/local/bin/
```

Verifique:

```bash
migrate -version
```

---

## 🛠️ Comandos para criar as migrações

Crie a migration inicial na pasta de migrações sql/mnigrations:

```bash
migrate create -ext=sql -dir=sql/migrations -seq init
```

Isso criará arquivos como:

```
db/migrations/
├── 000001_init.up.sql
├── 000001_init.down.sql
```

---

## ✍️ Exemplo de conteúdo das migrações

### `000001_init.up.sql`

```sql
CREATE TABLE categories (
  id VARCHAR(36) NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE courses (
  id VARCHAR(36) NOT NULL PRIMARY KEY,
  category_id VARCHAR(36) NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);
```

### `000001_init.down.sql`

```sql
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS courses;
```
---

### Subindo o container MySQL:

```bash
docker compose up -d
```

## 🚀 Executando as migrações

### Executando as Migrations no MySQL:

```bash
migrate -path sql/migrations -database "mysql://root:root@tcp(localhost:3306)/course_db" up
```

### Para reverter (rollback):

```bash
migrate -path sql/migrations -database "mysql://root:root@tcp(localhost:3306)/course_db" down
```

### Conferindo as tabelas dentro do Container MySQL

```bash
docker-compose exec mysql bash
bash# mysql -uroot -p course_db
bash# root
use course_db;
show tables;
```

---

EOF
