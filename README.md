<div align="center">

# 📝 Firebase Task Manager App

An enterprise-grade, state-aware Task Management application built using **Flutter** and **Riverpod**, powered by **Firebase Core**, **Authentication**, **Cloud Firestore**, and **FCM + Local Notifications**.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/State_Management-Riverpod-blue?style=for-the-badge)](https://riverpod.dev)
[![Firebase](https://img.shields.io/badge/Backend-Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

</div>

---

## 📌 Project Overview

This assignment project demonstrates a robust implementation of modern Flutter development practices. It provides complete Task Management (CRUD) capabilities synchronized in real-time with **Cloud Firestore**, backed by secure **Firebase Authentication** (Email/Password & Google Sign-In), and features a comprehensive multi-state notification system handling **FCM Push Notifications** and **Local Notifications**.

---

## ✨ Key Features & Highlights

### 🔐 Authentication & Authorization
- **Email & Password Auth:** Full registration and sign-in flow with error handling.
- **Google Sign-In:** One-tap OAuth integration for effortless access.
- **Reactive Auth State:** Real-time stream listening via Riverpod providers.

### 📋 Task Management (Firestore CRUD)
- **Real-Time Data Sync:** Live state updates for tasks powered by Cloud Firestore.
- **Complete Task Metadata:** Title, Description, Due Date, Priority (High / Medium / Low), and Completion Status.
- **Dynamic Filtering:** Instant switching between *Pending* and *Completed* task lists.
- **Live Search:** Fast, real-time search by task title or description.
- **Delete Guard:** Modal confirmation dialog before performing permanent deletion.

### 🔔 Advanced State-Aware Notifications
- **Firebase Cloud Messaging (FCM):** Topic-based broadcast (`all_tasks`) and direct payload messaging.
- **Foreground Local Notifications:** Auto-converts incoming FCM payloads into heads-up local notifications using `flutter_local_notifications`.
- **Full Lifecycle Handling:**
   - 🟢 **Foreground:** Shows immediate banner notification.
   - 🟡 **Background:** Handled natively by OS & Firebase messaging service.
   - 🔴 **Terminated:** Deep-links directly into the task editor upon user tap via global router.

---

## 🛠️ Tech Stack & Key Packages

| Category | Technology / Package | Purpose |
| :--- | :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) | Cross-platform UI Toolkit |
| **Language** | [Dart](https://dart.dev) | Client-optimized language |
| **State Management** | [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) | Reactive & compile-safe state management |
| **Authentication** | [`firebase_auth`](https://pub.dev/packages/firebase_auth) & [`google_sign_in`](https://pub.dev/packages/google_sign_in) | Firebase User Management & OAuth |
| **Database** | [`cloud_firestore`](https://pub.dev/packages/cloud_firestore) | NoSQL real-time cloud storage |
| **Push Messaging** | [`firebase_messaging`](https://pub.dev/packages/firebase_messaging) | Remote push notification service |
| **Local Alerts** | [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications) | Foreground heads-up banners & alerts |

---

## 📂 Architecture & Project Structure

```text
lib/
├── app.dart                       # Global MaterialApp & Routing config
├── main.dart                      # App entry point, FCM & Local Notification setup
├── firebase_options.dart          # Auto-generated Firebase configuration
│
├── core/
│   ├── app_exception.dart         # Custom exception models
│   └── constants.dart             # Colors, themes, and string constants
│
├── models/
│   └── task_model.dart            # Task entity model with Firestore converters
│
├── providers/
│   ├── auth_provider.dart         # Auth state & user session providers
│   ├── service_providers.dart    # FCM, Local Notifications & Riverpod containers
│   └── task_provider.dart        # Firestore CRUD stream & filter state notifiers
│
├── services/
│   ├── auth_service.dart          # Firebase Auth & Google Sign-In logic
│   ├── fcm_background_handler.dart# Isolated background messaging handler
│   ├── local_notification_service.dart # Local notification channel manager
│   └── notification_router.dart   # Deep-linking router logic for notifications
│
└── views/
    ├── auth/
    │   ├── login_screen.dart      # Login & Google Sign-In UI
    │   └── signup_screen.dart     # User registration UI
    └── tasks/
        ├── task_form_screen.dart  # Add & Edit Task modal form
        ├── task_list_screen.dart  # Main Task List dashboard with Search & Filter
        └── widgets/               # Modular UI components (TaskTile, FilterTabs, etc.)