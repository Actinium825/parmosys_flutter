import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading_state_provider.g.dart';

@riverpod
class LoadingState extends _$LoadingState {
  @override
  AsyncValue<dynamic> build() => const AsyncValue.data(null);

  void setLoading() => state = const AsyncLoading();

  void setError(Object error, StackTrace stackTrace) => state = AsyncError(error, stackTrace);

  void removeLoading() => state = const AsyncValue.data(null);
}
