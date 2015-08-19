# Proficiency test | Teste de proficiência

Teste de proficiência técnica para comprovar conhecimento em RubyOnRails, RSpec, Javascript, HTML5, CSS3 e PostgreSQL

Esse aplicativo esta hospedado no heroku. E pode ser acessado através do link:
https://proficiency-test-hugo.herokuapp.com/

## Detalhes para uso

Há uma conta de administrador já criada no banco de dados da aplicação hospeadada no heroku, a qual pode ser usada como exemplo:

**email: admin@example.com**

**senha: 123456**

## O que ainda poderia ser feito para melhorar a experiência do usuário com a aplicação

1. Além da opção de cadastrar estudante por seu perfil ou pelo perfil de algum curso, uma outra alternativa seria uma página apropriada para cadastramento em lote, com listagem e pesquisa tanto de estudantes quanto de curso realizada pelo administrador/professor.

2. Também seria interessante o uso de esquema **solicitação** realizado pelo aluno quando esse gostaria de tomar parte em um curso ou retirar do mesmo. *Obs: Esta última operação é, no momento, permitida diretamente pelo estudante, isto é, sem a necessidade de intervenção administrativa.*

3. Rastreamento de ações realizadas por administradores. Vincular cada matrícula a um histórico de interações com o sistema.

### O que poderia ser feito. *Visão de programador*

1. Maior uso de testes por features (capybara), requests ou routing. Estes testes tornam-se eficazes em TDD, mas acabam necessitando uma pre-visão muito bem concebida do produto final. Sem isso, criá-los necessita de *maior tempo*.

2. Separação na pipeline dos *assets* usados.

3. Tradução de recursos que interajam com a *camada de negócio* e de *visão de usuário*.
