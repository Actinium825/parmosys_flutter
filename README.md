# Flutter App for Project Parmosys

## Steps to run
1. Update to latest Flutter version
2. Place `env.dart` in `lib/utils/env.dart`
   <details>
   <summary>env.dart</summary>

   ```
   class Env {
      static const endpoint = '{your appwrite endpoint}';
      static const projectId = '{your appwrite project id}';
      static const databaseId = '{appwrite database id where collection is found}';
      static const database = '{appwrite or firebase}';
    }
   ```

   </details>
3. If using Firebase, replace `google-services.json` in `android/app/{google-services.json}` 
4. Run `flutter pub get`
5. Run `dart format -l 120 --set-exit-if-changed .`
6. Run `flutter pub run build_runner build --delete-conflicting-outputs`

## Features
- Flutter Carousel Widget
- Riverpod
- GoRouter
- Shared Preferences
- Package Info Plus
- Realtime Database (Appwrite or Firebase)
- Freezed
- Isar

## Credits
UI Designer: Jerone Lim

## Screenshots

### Start Page
<img src="/reference/screenshot/start_page.png" style="width:50%; height:auto" alt="Start Page">

### Category Page
| Light                                              | Dark                                              |
|----------------------------------------------------|---------------------------------------------------|
| ![](/reference/screenshot/category_page_light.png) | ![](/reference/screenshot/category_page_dark.png) |

### Menu
| Light                                     | Dark                                     |
|-------------------------------------------|------------------------------------------|
| ![](/reference/screenshot/menu_light.png) | ![](/reference/screenshot/menu_dark.png) |

### Area Page (Card View)
| Light                                                    | Dark                                                    |
|----------------------------------------------------------|---------------------------------------------------------|
| ![](/reference/screenshot/area_page_card_view_light.png) | ![](/reference/screenshot/area_page_card_view_dark.png) |

### Area Page (List View)
| Light                                                    | Dark                                                    |
|----------------------------------------------------------|---------------------------------------------------------|
| ![](/reference/screenshot/area_page_list_view_light.png) | ![](/reference/screenshot/area_page_list_view_dark.png) |

### Parking Space Page
| Light                                                   | Dark                                                   |
|---------------------------------------------------------|--------------------------------------------------------|
| ![](/reference/screenshot/parking_space_page_light.png) | ![](/reference/screenshot/parking_space_page_dark.png) |
