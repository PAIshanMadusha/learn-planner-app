# 📚 Learn Planner App

Learn Planner is a **Flutter-based** application that helps users manage their courses, assignments, and notes efficiently. The app provides a structured way to organize learning materials while ensuring persistence and ease of access. Additionally, it supports **light and dark theme persistence**, ensuring that the user's preferred theme remains unchanged even after restarting the app.

## 🚀 Features:

### 📌 Course Management:
- Users can **add courses** with details such as course name and description, etc.
- View a **single course** with its details.
- Users can **edit and delete courses** easily.

### 📝 Assignment Management:
- Users can **add assignments** related to a course, including details like the name, description, start date, due date, and ending time.
- View a **single assignment** with its details.
- Users can **edit and delete assignments**.
- **⏳ Assignment Deadline Timer**: Tracks due dates, and overdue assignments are displayed separately.

### 🗒️ Notes Management:
- Users can **add notes** related to a course, including a title, description, etc.
- Users can upload a **note image** for better understanding
- View a **single note** with its details.
- Users can **edit and delete notes**.

### 👤 Profile Management: 
- Users can **upload a profile picture**. 
- Users can **add and edit personal details** (e.g., name, email, age). 
- **User profile image and details persist across app restarts**. 

### 🌙 Dark & Light Mode Support: 
- The app supports **both dark and light modes**. 
- The selected theme **persists across app restarts**. 

### 📚 Data Storage & Real-Time Updates: 
- **Courses, assignments, and notes** are stored in **Firestore** for seamless access across devices. 
- **Note image** is stored in **Firebase Storage**, ensuring secure and scalable storage.
- The **Home Page** uses **StreamBuilder**, providing **real-time updates** whenever data changes.
- Other pages utilize **FutureBuilder**, fetching data **only when needed**, ensuring **optimized performance**. 
- **Profile details, including the selected theme**, are stored in **Shared Preferences**, ensuring persistence across app restarts.

### 🎨 Attractive UI Design:
- The app features a modern and user-friendly interface for a seamless experience.

## 🛠️ Technologies Used:
The following technologies are used in this project:

| Technology             | Description |
|------------------------|-------------|
| **Flutter**           | UI framework for building cross-platform applications. |
| **Dart**              | For application logic. |
| **Firebase Firestore**| NoSQL cloud database for storing courses, assignments, and notes. |
| **Firebase Storage**  | Used for storing uploaded a note image securely. |
| **Shared Preferences**| Stores profile details and theme preference locally. |
| **Provider**          | Manages theme state (dark/light mode) and ensures persistence. |
| **Go Router**         | For efficient navigation and deep linking. |
| **Google Fonts**      | Enables custom fonts for enhanced UI design. |
| **Image Picker**      | Allows users to pick and upload images. |
| **Flutter SVG**       | For displaying scalable vector graphics. |
| **Lottie**            | Adds smooth animations to the UI. |
| **Intl**              | Used for date formatting and localization support. |

## 📦 Dependencies Used:
The following dependencies are used in this project:
```yaml
  firebase_core: ^3.12.1
  cloud_firestore: ^5.6.5
  google_fonts: ^6.2.1
  go_router: ^14.8.1
  image_picker: ^1.1.2
  firebase_storage: ^12.4.4
  intl: ^0.20.2
  flutter_svg: ^2.0.17
  lottie: ^3.3.1
  shared_preferences: ^2.5.2
  provider: ^6.1.2
```

## 🚀 How to Run the Project:
1. Clone the repository:

```sh
https://github.com/PAIshanMadusha/learn-planner-app.git
```
2. Navigate to the project directory:

```sh
cd learn-planner-app
```
3. Install dependencies:

```sh
flutter pub get
```
## 📥 Set up Firebase:
   
### ⚠️ If you are unfamiliar with Firebase connecting:

- 📖I’ve written a detailed [Medium](https://medium.com/@ishanmadusha) article explaining the step-by-step process to connect Firebase to Flutter with screenshots.

- 📖**Read my blog on Medium here:** [Link](https://medium.com/@ishanmadusha/how-to-connect-firebase-manually-to-a-flutter-android-project-without-errors-7a2c2a8e2741)

- 📝**Also, you can view my previous project,** [Taskly Firebase App](https://github.com/PAIshanMadusha/taskly-firebase-app.git) I have written clearly on the README how to set up Firebase.

### 📝 To use Firebase services in this project, follow these steps:

- Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
- In the Firebase Console, on the left sidebar under the **Build** section, make sure to enable **Firebase Firestore** and **Firebase Storage** in **test mode**.
- Add Firebase to Your Flutter App: In Firebase Console, select either Android or iOS, depending on your target platform and, Fill the Required details.
- Download the `google-services.json` file (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the appropriate folders.

### ✅ All setup is complete. Now you can run the app. Make sure there are no errors:
   ```bash
   flutter run
   ```

## 📸 System Screenshots:
**Below you can view app screenshots related to the Course, Assignment, and Note pages, as well as the Light and Dark themes.**

---

<p align="center">
  <img src="https://github.com/user-attachments/assets/812c1430-341c-4d44-942d-e27808acd1bd" alt="Screenshot 1" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/62e7d4c1-8c28-4445-ab49-201bbd971d49" alt="Screenshot 2" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/25ac24d0-6a31-489a-9cba-5fa9dd20e07c" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/b7460e1a-be87-4ce0-a232-6d3ae323bd98" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/650563b2-7257-4200-8b4c-6d00a9cb9baa" alt="Screenshot 1" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/3d24e045-ea03-454c-88c8-35caa8de7b26" alt="Screenshot 2" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/f17d0311-d503-4ece-a26c-a3a8fe1dc90d" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/22163e91-202a-4443-a911-cf1c7bd00ee7" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/5b7299f4-c005-4fdc-af92-c8ef3db37fc8" alt="Screenshot 1" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/e2c497ef-2730-4d38-8008-178a791eda12" alt="Screenshot 2" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/1a312e0d-cfa5-47ad-a978-1b6dcec9a3e7" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/c2e18fc9-8aa5-4a99-867d-2aa32234ea64" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>

---
## 👤 About This Project:

The **Learn Planner** app is a Flutter-based application designed to help users efficiently manage their courses, assignments, and notes. It provides a streamlined way for users to add, view, edit, and delete their courses, assignments, and notes. With features like real-time updates, profile management, and dark/light theme support, the app offers an organized and user-friendly experience for students and learners.

I created this project to improve my **Flutter** and **Firebase** knowledge, as well as to enhance my development skills. I'm excited to share it with you, and I hope you find it useful!

### 👨‍💻 Created by: 
**Ishan Madhusha**  
GitHub: [PAIshanMadusha](https://github.com/PAIshanMadusha)

Feel free to explore my work and get in touch if you'd like to collaborate! 🚀

---

## 📝 License:
This project is open-source and available under the MIT License.
