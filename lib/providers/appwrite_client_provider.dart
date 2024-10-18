import 'package:appwrite/appwrite.dart';
import 'package:parmosys_flutter/utils/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appwrite_client_provider.g.dart';

@riverpod
Client appwriteClient(AppwriteClientRef ref) => Client()
  ..setEndpoint(Env.endpoint)
  ..setProject(Env.projectId);
