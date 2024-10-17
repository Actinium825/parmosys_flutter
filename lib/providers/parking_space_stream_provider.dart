import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/providers/selected_category_provider.dart';
import 'package:parmosys_flutter/utils/env.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:sprintf/sprintf.dart';

final parkingSpaceStreamProvider = StreamProvider.autoDispose((ref) {
  final client = Client()
    ..setEndpoint(Env.endpoint)
    ..setProject(Env.projectId);
  final realtime = Realtime(client);

  final selectedCategory = ref.read(selectedCategoryProvider);
  final collections = selectedCategory?.areas.map((area) => sprintf(parkingSpaceChannel, [area.toSnakeCase()]));
  final subscription = realtime.subscribe([...?collections]);

  return subscription.stream;
});
