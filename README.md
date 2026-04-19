# External Shine

<p align="center">
  <img src="assets/images/app_logo.png" alt="External Shine Logo" width="220" />
</p>

External Shine is a skincare and beauty e-commerce mobile application built with **Flutter** and **Dart**. The app focuses on a clean shopping experience where users can explore skincare products, view product details, read reviews, and discover related items in a soft, modern interface.

## General Info

- App name: `External Shine`
- Project type: `Flutter mobile application`
- Main topic: `Skincare and beauty e-commerce shop`
- Built with: `Flutter`, `Dart`, `Material 3`

## Features

- Browse skincare and beauty products
- View detailed product information
- Explore product galleries and promotional banners
- Read customer reviews with optional profile images
- See related products in reusable product cards
- Reusable widget-based architecture for easier maintenance

## Getting Started

### Prerequisites

Before you run the project, make sure you have these installed:

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Git
- A connected emulator or physical device

Check your Flutter setup with:

```bash
flutter doctor
```

## Run the Project Locally

If you already have the project on your computer:

```bash
cd project_path
flutter pub get
flutter run
```

## Beginner Git Guide

This section is for beginners who want to start from cloning the project until pushing code to a new branch.

### 1. Clone the Project

```bash
git clone https://github.com/Vuthy-Tourn/flutter_assignment
```

### 2. Move Into the Project Folder

```bash
cd flutter_assignment
```

If your folder name is different, use that folder name instead.

### 3. Install Project Dependencies

```bash
flutter pub get
```

### 4. Create and Switch to a New Branch

This command creates a new branch and checks out that branch at the same time:

```bash
git checkout -b your_name
```

### 5. Check Your Current Branch

```bash
git branch
```

The branch with `*` is your current branch.

### 6. Start Working

After you make changes, check what changed:

```bash
git status
```

## Flutter Helper Script

A helper script is included in the project root:

```bash
./flutter_git_push.sh
```

This script will:

- Check that you are inside a Git repository
- Check that Flutter is installed
- Run `flutter analyze`
- Run `flutter test`
- Add all changes
- Commit with your message
- Push to your current branch

### First Time Setup

Make the script executable:

```bash
chmod +x flutter_git_push.sh
```

### Usage

Run the script and enter the commit message when prompted:

```bash
./flutter_git_push.sh
```

Or pass the commit message directly:

```bash
./flutter_git_push.sh "Update product detail page"
```

### Example Workflow

```bash
git clone https://github.com/Vuthy-Tourn/flutter_assignment
cd flutter_assignment
flutter pub get
git checkout -b your_name
./flutter_git_push.sh "Add review section updates"
```

## Manual Git Commands

If you want to do everything manually instead of using the script:

### 7. Add Your Files

```bash
git add .
```

### 8. Commit Your Changes

```bash
git commit -m "Message for what you have done"
```

### 9. Push the Branch to GitHub

```bash
git push -u origin branch_name
```
### 10. Pull from others branch ( optional )

```bash
git fetch
git pull origin branch_name
```

