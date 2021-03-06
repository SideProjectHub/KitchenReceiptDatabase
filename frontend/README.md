
# KitchenDatabase Frontend 

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## File System: 
The file system we're using is adapted from *Chinmay Mourya* [blog](https://medium.com/flutter-community/flutter-scalable-folder-files-structure-8f860faafebd) which offers a scalable design for flutter apps. 

### Using APIs 

Route consts are listed in [frontend\lib\constants\api_path.dart]() 
They hold strings to the backend route.

Implementation and requirements to all backend api class are listed in [frontend\lib\services\rest_api_service.dart]()

```dart 
    String uid = Provider.of<kartUser?>(context, listen: false)?.uid ?? "uid";
    final response = await RestAPIService().getProfile(uid);
    print(response.statusCode);
```
*Example of using calling REST Api*

##### Notes: 
- If assests are needed, they are required to be placed in pubsec.yaml folder. 