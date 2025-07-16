## Requisitos

- Ruby 3.x
- Rails 7.x

---

## Instalação

1. Clone o repositório:

```bash
git clone git@github.com:gustavomgama/portabilis_app.git
cd portabilis_app
```

2. Instale as dependências
```ruby
bundle install
```
3. Criar banco de dados e migrações e seed
```bash
rails db:setup
rails db:migrate
```
4. Rodar o servidor
```ruby
bin/dev
```

## Exemplos de requisições:
1. Cria um usuário
- **POST /api/v1/users**
```json
{
  "user": {
    "email": "foo@bar.com",
    "password": "foo@bar.com",
    "password_confirmation": "123456"
  }
}
```
2. Desativa/Ativa um usuário
- **PATCH /api/v1/users/4**
- Especificar qual usuário você quer atualizar na URL

```json
{
  "user": {
    "active": false
  }
}
```
