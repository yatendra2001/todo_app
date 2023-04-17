# Flutter and Appwrite To-Do App

This repository contains the source code for a simple yet efficient to-do app built using Flutter and Appwrite. It demonstrates how to authenticate users, fetch, add, update, and delete tasks in a user-friendly interface.

![App Screenshot](app-screenshot.png)

## Features

- User authentication with email and password
- Add, edit, and delete tasks
- Mark tasks as completed
- Filter tasks based on their completion status
- Sign out functionality

## Getting Started

To set up and run this project locally, follow these steps:

1. Clone the repository:
```
git clone https://github.com/yourusername/flutter-appwrite-todo.git
cd flutter-appwrite-todo
```

2. Install the dependencies:
```
flutter pub get
```

3. Set up your [Appwrite](https://appwrite.io/) backend by following the instructions in the [Appwrite documentation](https://appwrite.io/docs/getting-started). Make sure to update the `endpoint`, `projectId`, `databaseId`, and `tasksCollectionId` in the `AppwriteService` class.

4. Run the app on an emulator or a physical device:
```
flutter run
```


## Tutorial Videos

A series of tutorial videos are available to help you build this app from scratch:

1. [Installing Flutter, Adding Appwrite as a Dependency, and Running the App on an Emulator/Browser](http://www.youtube.com/watch?v=MdM4pkIvD78)
2. [Making Your First Request + Authentication UI on Flutter](http://www.youtube.com/watch?v=34HH86sCKkk)
3. [Building a Simple To-Do App Using Appwrite and Flutter](http://www.youtube.com/watch?v=YOUR_VIDEO_ID)


## Contributing

If you'd like to contribute to this project, feel free to submit a pull request or open an issue for discussion. Thanks for contribution!

## License

This project is licensed under the [MIT License](LICENSE).

