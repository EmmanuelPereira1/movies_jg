# 🎬 Movies JG - Backend & Frontend

Este projeto consiste em uma aplicação completa com frontend em **Flutter** e backend em **Node.js** com **GraphQL**, integrando-se a um banco de dados **Neo4j**.

---

## 📁 Estrutura do Projeto

```
movies_jg_flutter/
│
├── backend/                 # Backend Node.js + GraphQL
│   ├── .env                 # Variáveis de ambiente (credenciais do Neo4j)
│   ├── neo4j/               # Driver de conexão com o Neo4j
│   ├── graphql/             # Schema e resolvers
│   ├── services/            # Lógica para buscar dados no banco
│   └── index.js             # Inicialização do Apollo Server
│
└── movies_jg_flutter/
                      lib/
                          └── ...              # Código Flutter
```

---

## Pré-requisitos

### Backend

- Node.js 18+
- Neo4j (pode ser local ou Aura Cloud)

### Frontend

- Flutter 3.24.5+
- Dart SDK

---

## Configuração

###  Backend

1. Vá para a pasta do backend:

```bash
cd backend
cd movies-api
```

2. Instale as dependências:

```bash
npm install
```

3. Crie um arquivo `.env` com suas credenciais do Neo4j:

```env
NEO4J_URI=bolt://<host>:<port>
NEO4J_USER=neo4j
NEO4J_PASSWORD=sua-senha-aqui
```

Exemplo:

```env
NEO4J_URI=bolt://54.172.149.159:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=whip-surpluses-shots
```

4. Inicie o servidor:

```bash
node index.js
```

Servidor deve rodar em: [http://localhost:4000](http://localhost:4000)

---

### Frontend (Flutter)

1. Instale as dependências:

```bash
flutter pub get
```

2. Configure a URL da API GraphQL para ambiente **mobile** e **web**:

```dart
final String baseUrl = kIsWeb
  ? 'http://localhost:4000/' // para web
  : Platform.isAndroid
    ? 'http://10.0.2.2:4000/' // emulador Android
    : 'http://localhost:4000/'; // iOS ou desktop
```

4. Execute o projeto:

```bash
flutter run
```

Para web:

```bash
flutter run -d chrome
```

---

## Testes

- Para testar o backend manualmente, acesse [http://localhost:4000](http://localhost:4000) e use o playground GraphQL para testar queries como:

```graphql
query {
  movies {
    properties {
      title
      released
    }
    actors {
      name
    }
  }
}
```

---

## Estrutura de Pastas (Backend)

- `neo4j/driver.js`: conexão com o banco
- `services/getMovies.js`: lógicas de busca
- `graphql/resolvers.js`: resolvers do GraphQL
- `graphql/typeDefs.js`: schemas GraphQL

---

## Extras

- Use arquivos `.gql` no Flutter com [graphql_flutter](https://pub.dev/packages/graphql_flutter) para organizar queries:
  - Crie uma pasta `lib/graphql/queries/`
  - Salve queries como arquivos `.gql`, por exemplo:

```graphql
# lib/graphql/queries/movies.gql
query GetMovies {
  movies {
    properties {
      title
    }
  }
}
```

- Carregue com `gql(readFile(...))` usando `flutter/services.dart`.
