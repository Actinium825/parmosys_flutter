# Flutter App for Project Parmosys

A Flutter Mobile App in tandem with Parmosys Tensorflow Yolov4 Python App to show the available parking spaces in realtime. 
Choose either Appwrite or Firebase whichever was used in the Python App. 
The state management for the mobile app is Riverpod with Shared Prefs for saving the selected theme and card view modes.
Isar is applied for the local database, storing the parking spaces data. 
GoRouter is used for routing. 
This is my thesis project for my 4th year at university so areas/spaces in the mobile app are from there.

## Contents
- [Steps to run](#steps-to-run)
- [Features](#features)
- [Credits](#credits)
- [Screenshots](#screenshots)

## Steps to run
1. Update to latest Flutter version
2. Setup database:
   <details>
   <summary>Appwrite</summary>
    
     1. Copy your Appwrite's Project ID and replace `projectId` in `lib/utils/env.dart`
     2. Set `database` in `lib/utils/env.dart` to `appwrite`

   </details>

   <details>
   <summary>Firebase</summary>
   
     1. Add Android to your Firebase project with package name `com.example.parmosys_flutter`
     2. Download the `google-services.json` and replace in `android/app`
     3. Add iOS to your Firebase project with bundle ID `com.example.parmosysFlutter`
     4. Download the `GoogleService-Info.plist` and using Xcode, place under `Runner`
     5. Set `database` in `lib/utils/env.dart` to `firebase`
   
   </details>
3. Run `flutter pub get`
4. Run `flutter pub run build_runner build --delete-conflicting-outputs`

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
