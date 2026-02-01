// API Configuration - Single Responsibility Principle (SRP)
// Centralized configuration management
class ApiConfig {
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500/';
  static const String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZmVhNDBkNzg2ZmE5OTNlYTg3M2U4MmNjZDBiMTkwYiIsIm5iZiI6MTYxMjQ4MTYwMS4yNzksInN1YiI6IjYwMWM4NDQxMTEwOGE4MDAzZWM0NDMxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t9G-Lthocb2yqFT6nWECqGhjFh4_DXLtTNjo076y3bg';

  static Map<String, String> get headers => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
}
