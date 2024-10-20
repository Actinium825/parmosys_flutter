import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/providers/appwrite_client_provider.dart';
import 'package:parmosys_flutter/providers/selected_category_provider.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:sprintf/sprintf.dart';

final appwriteStreamProvider = StreamProvider.autoDispose<RealtimeMessage>((ref) {
  final client = ref.read(appwriteClientProvider);
  final realtime = Realtime(client);

  final selectedCategory = ref.read(selectedCategoryProvider);
  final areas = [...?selectedCategory?.areas];
  final collections = areas.map((area) => sprintf(parkingSpaceChannel, [area.toSnakeCase()])).toList();
  final subscription = realtime.subscribe(collections);

  return subscription.stream;
});
