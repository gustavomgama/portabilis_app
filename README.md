## Requisitos
- Ruby 3.x  
- Rails 7.x
---

## Instalação
1. Clone o repositório:
```bash
   git clone git@github.com:gustavomgama/portabilis_app.git
   cd portabilis_app
````

2. Instale as dependências:
```ruby
bundle install
```

3. Crie o banco de dados, execute as migrações e o seed:
```bash
rails db:setup
rails db:migrate
```

O seed cria dois usuários:
**Admin**
* Email: `a@a.com`
* Senha: `a@a.com`
  
**Usuário normal**
* Email: `t@t.com`
* Senha: `t@t.com`

4. Inicie o servidor:
```bash
bin/dev
```
## Exemplos de Requisições
### 1. Criar um usuário
**POST /api/v1/users**
```json
{
"user": {
  "email": "foo@bar.com",
  "password": "foo@bar.com",
  "password_confirmation": "foo@bar.com"
  }
}
```
### 2. Ativar ou desativar um usuário
**PATCH /api/v1/users/\:id**
  Substitua `:id` pelo ID do usuário a ser atualizado.
```json
{
"user": {
  "active": false
  }
}
  ```
