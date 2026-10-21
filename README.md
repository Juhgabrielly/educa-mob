# Educa Finança

Aplicativo Flutter de educação financeira.

## Dados e backend

As telas consomem dados por meio do contrato `AppRepository`, definido em
`lib/data/app_repository.dart`. A implementação ativa é `DemoAppRepository`,
injetada em `lib/main.dart`; ela mantém os dados demonstrativos fora da
interface e implementa as mesmas operações assíncronas que uma integração
remota deverá fornecer.

Para conectar o backend:

1. Implemente `AppRepository` com o transporte e os endpoints definidos pelo
   backend.
2. Faça a implementação converter respostas para os modelos tipados do
   contrato e propagar falhas como exceções.
3. Injete a implementação remota em `EducaFinancaApp` no `main.dart`, no lugar
   de `DemoAppRepository`.

O projeto ainda não está conectado a um servidor: URL, autenticação, formato
das respostas e endpoints devem ser definidos junto ao backend. A implementação
demonstrativa não valida credenciais e não deve ser usada como autenticação de
produção.
