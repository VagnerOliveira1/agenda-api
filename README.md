# Agenda

Uma aplicação para adicionar e fazer a gestão de contatos, a gestão é feita por usuários autenticados.

## 🚀 Começando
Nesse repositório contém o back-end da aplicação, o front-end [web](https://github.com/VagnerOliveira1/web) - utilizando Next e React

### 📋 Pré-requisitos

* rails => 6.1.7.2
* ruby => 3.1.3
* postgres => 14.6


### 🔧 Instalação
Execute ```bundle exec rake dev:setup ```<br>
O banco será criado e inserido vários dados entre eles <br>
o de um admim padrão que será <br>
```nome: admim ```<br>
```email: admim@admim.com ```<br>
```senha: 123456```<br>

Ao carregar a aplicação o usuário poderá criar a sua conta ou fazer o login<br>
Caso possua um perfil ```admin``` será direcionado para uma tela <br>
onde ele pode fazer a gestão dos contatos cadastrados e também dos outros usuários.


## ⚙️ Executando os testes

bundle exec rspec

Os testes foram implementados na parte de requests, de models,<br> 
paginação, busca de uma forma que pode ser reutilizada.

## 📦 Implantação

o back-end da aplicação foi hospedada no heroku <br>e o endreço é: https://infinite-beach-09577.herokuapp.com/

## 🛠️ Em construção
* Listagem dos usuarios admins e Manager
* Permissões de usuários de perfil do tipo manager(Hoje apenas o admin consegue visualizar os contatos)
