import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/utils/env.dart';

final parkingSpacesProvider = FutureProvider<DocumentList>((ref) async {
  final client = Client()
    ..setEndpoint(Env.endpoint)
    ..setProject(Env.projectId);
  final database = Databases(client);

  return database.listDocuments(databaseId: Env.databaseId, collectionId: Env.collectedId);
});
