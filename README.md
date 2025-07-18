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
3-1. Seed cria dois usuários:
admin: 
email: a@a.com
senha: a@a.com
usário normal:
email: t@t.com
senha: t@t.com

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
    "password_confirmation": "foo@bar.com"
  }
}
```
2. Desativa/Ativa um usuário
- **PATCH /api/v1/users/4**
- Especificar qual usuário você quer atualizar na URL passando o ID do usuário

```json
{
  "user": {
    "active": false
  }
}
```
