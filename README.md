# Json to Form

A flutter project showing you implementation of how you can generate a full fledged form from the list of items provided to you in a JSON locally or through an API.

### Process Followed
* Creating a `localValuesMap` which will be holding the key/id of the item and the initial value. For type `yes_no` initial value would be no, for others it would be empty string.
* Creating a variable widgets for holding the list of items which would be created on the basis of json which we have been provided with. In the code `createItemWidgets` would be doing this. Make sure to pass key to each item. If value of the widget is changes, it would be updated in `localValuesMap`.
* Displaying the items from the list in a form such that validations work. For the widgets which do not provide us with a feature for validation, we have to write custom validation basis of their value.
* On all validations passing, we can show the data in an `AlertDialogBox` and closing this we can re-launch the `FormScreen` for a fresh start.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
