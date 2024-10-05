import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/utils/strings.dart';

enum ParkingCategory {
  colleges(collegesHeader, collegesAreas),
  halls(hallsHeader, hallsAreas),
  recreational(recreationalHeader, recreationalAreas);

  const ParkingCategory(this.header, this.areas);

  final String header;
  final List<String> areas;

  String get imageUrl {
    const png = Assets.png;
    return [png.colleges.path, png.halls.path, png.recreational.path][index];
  }

  String cardAreaImageUrl(int index) {
    const png = Assets.png;
    return switch (this) {
      ParkingCategory.colleges => [png.chtm.path, png.cict.path, png.law.path, png.cssp.path][index],
      ParkingCategory.halls => png.hall.path,
      ParkingCategory.recreational => [
          png.activityCenter.path,
          png.heroesPark.path,
          png.library.path,
          png.universityHostel.path
        ][index],
    };
  }
}

enum AreaView {
  gridView,
  listView;

  bool get isGridView => this == gridView;
}
