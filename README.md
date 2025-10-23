# Bus2 Test App - Random User

Aplicativo Flutter que consome a API Random User (https://randomuser.me/api/) e implementa persistência local de dados usando SQLite.

## 🎯 Objetivo

Criar um aplicativo que exibe informações de pessoas aleatórias consumidas de uma API pública, com funcionalidade de salvar/remover usuários localmente.

## 🏗️ Arquitetura

O projeto segue **Clean Architecture** com a seguinte estrutura:

```
lib/
├── core/
│   ├── di/                     # Dependency Injection (GetIt)
│   ├── usecases/              # UseCase base class
│   └── utils/                 # Utilidades
├── data/
│   ├── datasources/           # Remote (HTTP) e Local (SQLite)
│   ├── models/                # Data models (JSON parsing)
│   └── repositories/          # Repository implementations
├── domain/
│   ├── entities/              # Business entities
│   ├── repositories/          # Repository interfaces
│   └── usecases/              # Business logic use cases
└── presentation/
    ├── cubits/                # Cubit (State Management)
    ├── pages/                 # Screens/Pages
    └── widgets/               # Reusable widgets
```

## 🔧 Tecnologias Utilizadas

- **Flutter SDK**: Framework principal
- **Cubit (flutter_bloc)**: Gerenciamento de estado
- **GetIt**: Injeção de dependência
- **Provider**: Prover dependências aos widgets
- **SQLite (sqflite)**: Persistência local de dados
- **HTTP**: Requisições à API
- **Equatable**: Comparação de objetos

## 📱 Funcionalidades

### 1. Tela Inicial (Home Page)
- ✅ Exibe lista de usuários aleatórios
- ✅ Usa **Ticker** (não Timer) para buscar novo usuário a cada 5 segundos
- ✅ Persiste automaticamente os usuários buscados
- ✅ Botão para navegar para usuários salvos (ícone de database)
- ✅ Clique no card redireciona para detalhes

### 2. Tela de Detalhes (User Detail Page)
- ✅ Exibe todas as informações do usuário em grupos
- ✅ Mostra foto, nome, email, localização, etc.
- ✅ Botão para salvar/remover dos persistidos
- ✅ Status visual se usuário está salvo

### 3. Tela de Usuários Salvos (Saved Users Page)
- ✅ Lista de todos os usuários salvos localmente
- ✅ Clique no card abre detalhes
- ✅ Botão de remoção em cada card
- ✅ Confirmação antes de remover
- ✅ Atualização automática ao retornar dos detalhes

## 🎨 Padrões Implementados

### Clean Architecture
- **Domain**: Entidades e regras de negócio puras
- **Data**: Implementação de datasources e repositories
- **Presentation**: UI e gerenciamento de estado

### MVVM (Model-View-ViewModel)
- **Model**: Entities e Models
- **View**: Pages e Widgets (Flutter)
- **ViewModel**: Cubits (gerenciam estado e lógica de apresentação)

### Repository Pattern
- Abstração de datasources
- Separação entre remote (API) e local (Database)
- Interface no domain, implementação no data

### Dependency Injection
- GetIt para registro de dependências
- Provider para disponibilizar no contexto
- Facilita testes e manutenção


## 🚀 Como Executar

1. Certifique-se de ter o Flutter instalado:

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

## 📝 Características Técnicas Importantes


### Persistência SQLite
- Banco de dados local com sqflite
- CRUD completo de usuários
- Consultas otimizadas com índices

### Tratamento de Erros
- Try-catch em todas as operações assíncronas
- Estados de erro nos Cubits
- Feedback visual ao usuário


## 🎯 Requisitos Atendidos

- ✅ Consumo da API Random User
- ✅ Orientação a Objetos
- ✅ Parse de JSON para Dart
- ✅ Conversão para estrutura de persistência
- ✅ Padrão MVVM
- ✅ Repository Strategy
- ✅ Clean Architecture
- ✅ Cubit para gerenciamento de estado
- ✅ Provider para injeção de dependência
- ✅ Ticker (não Timer)
- ✅ Três telas funcionais
- ✅ Persistência local com SQLite


