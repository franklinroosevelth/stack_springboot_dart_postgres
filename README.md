# TodoList Application

Application de gestion de tâches avec **Flutter** (frontend), **Spring Boot** (backend) et **PostgreSQL** (base de données).

## 📁 Structure du projet

```
todolist/
├── backend/                 # API Spring Boot
│   ├── src/main/java/com/todolist/
│   │   ├── controller/      # Endpoints REST
│   │   ├── model/           # Entités JPA
│   │   ├── repository/      # Accès données
│   │   └── service/         # Logique métier
│   ├── Dockerfile
│   └── pom.xml
├── frontend/                # Application Flutter Web
│   ├── lib/
│   │   ├── models/          # Modèles de données
│   │   ├── providers/       # State management
│   │   ├── screens/         # Écrans
│   │   ├── services/        # Appels API
│   │   └── widgets/         # Composants UI
│   ├── Dockerfile
│   └── pubspec.yaml
├── docker-compose.yml
└── .env
```

## 🚀 Démarrage rapide

### Avec Docker Compose (recommandé)

```bash
docker-compose up --build
```

L'application sera accessible sur :
- **Frontend** : http://localhost:8080
- **Backend API** : http://localhost:8081/api/todos
- **PostgreSQL** : localhost:5432

### Développement local

#### Backend (Spring Boot)
```bash
cd backend
mvn spring-boot:run
```

#### Frontend (Flutter)
```bash
cd frontend
flutter pub get
flutter run -d chrome
```

## 📡 API Endpoints

| Méthode | Endpoint | Description |
|---------|----------|-------------|
| GET | `/api/todos` | Liste toutes les tâches |
| GET | `/api/todos/{id}` | Récupère une tâche |
| POST | `/api/todos` | Crée une tâche |
| PUT | `/api/todos/{id}` | Modifie une tâche |
| PATCH | `/api/todos/{id}/toggle` | Bascule le statut |
| DELETE | `/api/todos/{id}` | Supprime une tâche |

## 🔧 Configuration

Variables d'environnement (`.env`) :
```env
POSTGRES_DB=gestion_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres123
```

## ✨ Fonctionnalités

- ✅ Créer, modifier, supprimer des tâches
- ✅ Marquer comme terminé/en cours
- ✅ Filtrer par statut (toutes, en cours, terminées)
- ✅ Interface moderne Material Design 3
- ✅ Responsive (web)
