import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/area/area_carousel.dart';
import 'package:parmosys_flutter/feature/area/area_list.dart';
import 'package:parmosys_flutter/providers/selected_category_provider.dart';
import 'package:parmosys_flutter/providers/selected_view_provider.dart';
import 'package:parmosys_flutter/utils/enums.dart';

class AreaBody extends ConsumerWidget {
  const AreaBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGridView = ref.watch(selectedViewProvider).isGridView;
    final selectedCategory = ref.read(selectedCategoryProvider) ?? ParkingCategory.colleges;

    return isGridView ? AreaCarousel(selectedCategory: selectedCategory) : AreaList(selectedCategory: selectedCategory);
  }
}
