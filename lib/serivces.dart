import 'package:flutter/foundation.dart';

enum ApiService {
  GraphQLAPI(kDebugMode
      ? "http://localhost:3000/graphql"
      : 'https://derdevam.com/graphql');

  final String path;
  const ApiService(this.path);
}
