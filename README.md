# Movie App

A production-ready Flutter application showcasing **Clean Architecture**, **SOLID principles**, and modern Flutter development best practices. This app provides a beautiful interface for discovering movies and exploring popular people using The Movie Database (TMDB) API.

---

## Table of Contents

- [Architecture Overview](#architecture-overview)
- [SOLID Principles](#solid-principles)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Features](#features)
- [Key Design Decisions](#key-design-decisions)
- [Setup Instructions](#setup-instructions)
- [Code Generation](#code-generation)
- [Dependencies](#dependencies)

---

## Architecture Overview

This project implements **Clean Architecture** (also known as Onion Architecture or Hexagonal Architecture) with three distinct, independent layers. Each layer has specific responsibilities and dependencies flow inward, ensuring maximum testability, maintainability, and scalability.

### 1. Domain Layer (Business Logic Core)

The **innermost layer** containing pure business logic with zero dependencies on external frameworks or libraries.

**Components:**

- **Entities**: Pure Dart classes representing core business models
  - `MovieEntity`: Represents a movie with essential properties (id, title, rating, etc.)
  - `PersonEntity`: Represents a person/actor
  - `MovieDetailsEntity`: Extended movie information with budget, revenue, runtime, etc.

- **Repository Interfaces**: Abstract contracts defining data operations
  - `MoviesRepository`: Defines methods for fetching movies data
  - `PeopleRepository`: Defines methods for fetching people data
  - Uses **Dependency Inversion Principle** - domain defines the contract, data layer implements it

- **Use Cases**: Single-responsibility business logic operations
  - `GetTopRatedMoviesUseCase`: Fetches top-rated movies with validation
  - `GetPopularMoviesUseCase`: Fetches popular movies
  - `GetDiscoverMoviesUseCase`: Fetches discover movies
  - `GetMovieDetailsUseCase`: Fetches detailed movie information
  - `GetPopularPeopleUseCase`: Fetches popular people
  - Each use case handles ONE specific business operation

**Why this matters**:
- Business logic remains pure and testable
- No dependency on UI frameworks, databases, or HTTP clients
- Can be reused across different platforms (mobile, web, desktop)

---

### 2. Data Layer (Data Management)

The **middle layer** responsible for data retrieval, transformation, and storage.

**Components:**

- **Models**: Data transfer objects with JSON serialization
  - `MovieModel`: JSON-serializable movie data from API
  - `PersonModel`: JSON-serializable person data
  - `MovieDetailsModel`: Extended movie details
  - Uses `json_serializable` for automatic code generation
  - Each model has a `toEntity()` method to convert to domain entities

- **Data Sources**:
  - **Remote Data Sources** (Retrofit): Type-safe HTTP API clients
    - `MoviesRemoteDataSource`: Retrofit interface for movies API
    - `PeopleRemoteDataSource`: Retrofit interface for people API
    - Automatic request/response serialization
    - Built-in error handling

- **Repository Implementations**:
  - `MoviesRepositoryImpl`: Implements `MoviesRepository` interface
  - `PeopleRepositoryImpl`: Implements `PeopleRepository` interface
  - Fetches data from remote sources
  - Handles errors and converts to domain `Failure` types
  - Converts models to entities using `toEntity()`
  - Returns `Either<Failure, Success>` using Dartz

**Why Retrofit over manual Dio?**
- **80% less boilerplate code** - Just annotate interfaces, Retrofit generates implementation
- **Type safety** - Compile-time checking of API calls
- **Automatic serialization** - No manual JSON parsing
- **Error handling** - Built-in error conversion
- **Maintainability** - Less code = fewer bugs

---

### 3. Presentation Layer (UI & State Management)

The **outermost layer** handling user interface and user interactions.

**Components:**

- **Cubit (State Management)**:
  - `MoviesCubit`: Manages movies screen state
    - Methods: `loadMovies()`, `loadMovieDetails(movieId)`
    - States: `MoviesInitialState`, `MoviesLoadingState`, `MoviesLoadedState`, `MoviesErrorState`
  - `PeopleCubit`: Manages people screen state
    - Methods: `loadPeople()`
    - States: `PeopleInitialState`, `PeopleLoadingState`, `PeopleLoadedState`, `PeopleErrorState`
  - **Why Cubit over Bloc?**
    - Simpler API - methods instead of events
    - Less boilerplate - no need for event classes
    - Easier to understand and maintain
    - Perfect for straightforward state changes

- **UI Components**:
  - **Screens**:
    - `MoviesScreen`: Displays top-rated, popular, and discover movies
    - `MovieDetailsScreen`: Shows detailed movie information with modern UI
    - `PeopleScreen`: Grid of popular people
  - **Widgets**:
    - `DiscoverMovieCard`: Horizontal movie card
    - `HomeMovieCard`: Vertical movie card with rating
    - `PeopleCard`: Person card with image

---

## SOLID Principles

This project demonstrates all five SOLID principles:

### 1. Single Responsibility Principle (SRP)
Each class has ONE reason to change:
- Use cases handle ONE business operation
- Repositories handle ONE data source
- Cubits manage ONE screen's state
- Widgets render ONE UI component

### 2. Open/Closed Principle (OCP)
Classes are open for extension, closed for modification:
- Abstract repository interfaces allow new implementations without changing use cases
- New data sources can be added without modifying repositories
- New failure types can be added without changing error handling logic

### 3. Liskov Substitution Principle (LSP)
Implementations can replace interfaces without breaking functionality:
- `MoviesRepositoryImpl` can be swapped for any `MoviesRepository` implementation
- Mock repositories for testing work seamlessly

### 4. Interface Segregation Principle (ISP)
Interfaces are specific and focused:
- `MoviesRemoteDataSource` only defines movie-related methods
- `PeopleRemoteDataSource` only defines people-related methods
- Clients don't depend on methods they don't use

### 5. Dependency Inversion Principle (DIP)
High-level modules depend on abstractions, not concrete implementations:
- Use cases depend on `Repository` interfaces, not implementations
- Cubits depend on `UseCase` abstractions
- Data sources are injected via constructor (GetIt)

---

## Tech Stack

### Core Libraries

| Library | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^9.1.1 | State management using Cubit pattern |
| `get_it` | ^8.0.2 | Service locator for dependency injection |
| `dio` | ^5.9.0 | HTTP client for API requests |
| `retrofit` | ^4.5.0 | Type-safe REST client generator |
| `dartz` | ^0.10.1 | Functional programming (Either type for error handling) |
| `equatable` | ^2.0.7 | Value equality for entities and states |

### Code Generation

| Library | Version | Purpose |
|---------|---------|---------|
| `json_serializable` | ^6.11.4 | Generate JSON serialization code |
| `retrofit_generator` | ^10.2.1 | Generate Retrofit implementation |
| `build_runner` | ^2.10.5 | Code generation runner |

### Additional

| Library | Version | Purpose |
|---------|---------|---------|
| `intl` | ^0.20.2 | Internationalization and formatting |
| `auto_route` | ^11.1.0 | Navigation |

---

## Project Structure

```
lib/
├── core/                                    # Shared core functionality
│   ├── config/
│   │   └── api_config.dart                  # API base URL, headers, tokens
│   ├── di/
│   │   └── injection_container.dart         # GetIt dependency injection setup
│   └── error/
│       └── failures.dart                    # Failure types (ServerFailure, NetworkFailure, etc.)
│
├── features/                                # Feature-based architecture
│   ├── movies_feature/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── movies_remote_data_source.dart        # Retrofit API interface
│   │   │   │   └── movies_remote_data_source.g.dart      # Generated Retrofit implementation
│   │   │   ├── models/
│   │   │   │   ├── movie_model.dart                      # JSON model
│   │   │   │   ├── movie_model.g.dart                    # Generated JSON serialization
│   │   │   │   ├── movie_details_model.dart
│   │   │   │   ├── movie_details_model.g.dart
│   │   │   │   ├── movies_response_model.dart
│   │   │   │   └── movies_response_model.g.dart
│   │   │   └── repositories/
│   │   │       └── movies_repository_impl.dart           # Repository implementation
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── movie_entity.dart                     # Pure business model
│   │   │   │   ├── movie_details_entity.dart
│   │   │   │   └── genre_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── movies_repository.dart                # Repository interface
│   │   │   └── usecases/
│   │   │       ├── get_top_rated_movies_usecase.dart
│   │   │       ├── get_popular_movies_usecase.dart
│   │   │       ├── get_discover_movies_usecase.dart
│   │   │       └── get_movie_details_usecase.dart
│   │   │
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── movies_cubit.dart                     # State management
│   │       │   └── movies_state.dart                     # State definitions
│   │       └── ui/
│   │           ├── screens/
│   │           │   ├── movies_screen.dart                # Home screen
│   │           │   └── movie_details_screen.dart         # Details screen
│   │           └── widgets/
│   │               ├── discover_movie_card.dart
│   │               └── home_screen_movie_card.dart
│   │
│   └── people_feature/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── people_remote_data_source.dart        # Retrofit API interface
│       │   │   └── people_remote_data_source.g.dart      # Generated implementation
│       │   ├── models/
│       │   │   ├── person_model.dart
│       │   │   ├── person_model.g.dart
│       │   │   ├── people_response_model.dart
│       │   │   └── people_response_model.g.dart
│       │   └── repositories/
│       │       └── people_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── person_entity.dart
│       │   ├── repositories/
│       │   │   └── people_repository.dart
│       │   └── usecases/
│       │       └── get_popular_people_usecase.dart
│       │
│       └── presentation/
│           ├── cubit/
│           │   ├── people_cubit.dart
│           │   └── people_state.dart
│           └── ui/
│               ├── screens/
│               │   └── people_screen.dart
│               └── widgets/
│                   └── people_card.dart
│
├── main.dart                                # App entry point
└── main_screen_wrapper.dart                 # Bottom navigation wrapper
```

---

## Features

### Movies Section
- **Top Rated Movies**: Horizontal scrollable list of critically acclaimed movies
- **Popular Movies**: Grid layout of trending movies
- **Discover Movies**: Carousel of featured movies
- **Movie Details**:
  - Cinematic backdrop with gradient overlay
  - SliverAppBar with parallax scrolling
  - Comprehensive information (rating, budget, revenue, runtime)
  - Genre tags with gradient styling
  - Release date and status
  - User ratings with vote count
  - Modern material design

### People Section
- **Popular People**: Grid of trending actors and directors
- **Profile Images**: High-quality actor headshots
- **Interactive Cards**: Smooth hover/tap interactions

### Technical Features
- **Error Handling**: Graceful error states with retry buttons
- **Loading States**: Smooth loading indicators
- **Offline Support**: Error messages for network issues
- **Concurrent API Calls**: Parallel requests for better performance
- **Type-Safe API Calls**: Retrofit ensures compile-time safety

---

## Key Design Decisions

### Why Cubit over Bloc?
- **Simpler mental model**: Call methods instead of dispatching events
- **Less boilerplate**: No event classes needed
- **Easier debugging**: Direct method calls are easier to trace
- **Sufficient for our use case**: Simple state transitions don't need event complexity

### Why Retrofit over manual Dio?
- **Code reduction**: ~80% less code compared to manual implementation
- **Type safety**: Compile-time checking of endpoints and parameters
- **Automatic serialization**: No manual `fromJson` calls in data sources
- **Error handling**: Built-in error conversion and logging
- **Documentation**: Annotations serve as inline API documentation

### Why GetIt for DI?
- **Service locator pattern**: Simple and straightforward
- **No BuildContext needed**: Access dependencies anywhere
- **Lazy loading**: Dependencies created only when needed
- **Testing friendly**: Easy to register mocks

### Why Dartz Either?
- **Explicit error handling**: Forces handling of both success and failure cases
- **Functional approach**: Railway-oriented programming
- **Type safety**: Compiler ensures all cases are handled
- **No exceptions**: Errors are values, not thrown

---

## Setup Instructions

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK
- TMDB API Key ([Get one here](https://www.themoviedb.org/settings/api))

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd movie_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**

   Open `lib/core/config/api_config.dart` and add your TMDB API key:
   ```dart
   class ApiConfig {
     static const String baseUrl = 'https://api.themoviedb.org';
     static const String apiKey = 'YOUR_API_KEY_HERE';

     static Map<String, String> get headers => {
       'Authorization': 'Bearer $apiKey',
       'Content-Type': 'application/json',
     };
   }
   ```

4. **Run code generation**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

   This generates:
   - JSON serialization code (`*.g.dart` for models)
   - Retrofit implementation (`*_remote_data_source.g.dart`)

5. **Run the app**
   ```bash
   flutter run
   ```

---

## Code Generation

This project uses code generation for:

### 1. JSON Serialization (`json_serializable`)

**Example:**
```dart
@JsonSerializable()
class MovieModel {
  final int id;
  final String title;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
```

**Generate code:**
```bash
flutter pub run build_runner build
```

### 2. Retrofit API Clients

**Example:**
```dart
@RestApi()
abstract class MoviesRemoteDataSource {
  factory MoviesRemoteDataSource(Dio dio) = _MoviesRemoteDataSource;

  @GET('/3/movie/popular')
  Future<MoviesResponseModel> getPopularMovies(@Query('page') int page);
}
```

**What gets generated:**
- Complete Dio implementation with error handling
- Automatic JSON serialization/deserialization
- Query parameter and path variable handling
- Type-safe HTTP calls

### Code Generation Commands

```bash
# One-time build
flutter pub run build_runner build

# Delete conflicting outputs (recommended)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild on file changes)
flutter pub run build_runner watch

# Clean generated files
flutter pub run build_runner clean
```

---

## Dependencies

### Why Each Dependency?

**flutter_bloc**: Industry-standard state management with excellent documentation and community support. Cubit provides a simpler API than full Bloc while maintaining all benefits.

**get_it**: Lightweight service locator that doesn't require BuildContext. Perfect for Clean Architecture where layers shouldn't depend on Flutter framework.

**dio**: Powerful HTTP client with interceptors, retries, and excellent error handling. Foundation for Retrofit.

**retrofit**: Generates type-safe REST API clients. Reduces boilerplate by 80% compared to manual Dio implementation.

**dartz**: Brings functional programming patterns to Dart. Either type makes error handling explicit and type-safe.

**equatable**: Simplifies value equality for entities and states. Essential for Cubit/Bloc state comparison.

**json_serializable**: Generates efficient JSON serialization code. Safer and faster than manual parsing.

**intl**: Handles number formatting (currency, ratings) and date formatting.

---

## Testing

The architecture supports comprehensive testing:

- **Unit Tests**: Test use cases and entities with zero dependencies
- **Widget Tests**: Test UI components in isolation
- **Integration Tests**: Test complete features end-to-end
- **Mock Testing**: Easy with GetIt - register mocks instead of real implementations

Example:
```dart
// Register mock repository for testing
sl.registerLazySingleton<MoviesRepository>(
  () => MockMoviesRepository(),
);
```

---

## Future Enhancements

- Add local caching (Hive/Drift) for offline support
- Implement search functionality
- Add favorites/watchlist feature
- Support for TV shows
- User authentication
- Movie trailers integration
- Pagination for infinite scrolling
- Dark/Light theme toggle

---

## License

This project is a demonstration of Clean Architecture and Flutter best practices.

---

## Credits

- Movie data provided by [The Movie Database (TMDB)](https://www.themoviedb.org/)
- Built with Flutter and love [Qasem Zraiq]
