import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/utils/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appwrite_client_provider.g.dart';

@riverpod
Client appwriteClient(Ref ref) => Client()
  ..setEndpoint(Env.endpoint)
  ..setProject(Env.projectId);
