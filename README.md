# MyYogaPlan TCA Project

This project is a demo application designed to showcase my expertise in iOS development using The Composable Architecture (TCA). 

It integrates multiple features, such as browsing yoga categories and managing favorite poses to demonstrate clean architecture, state management, and testing capabilities with TCA.

## Features

- **Yoga Categories**: Browse and load a variety of yoga categories.
- **Favorite Poses**: Manage and favorite yoga poses, with persistent storage.
- **Composable Architecture**: Modular and scalable code using TCA.
- **State Management**: Efficient state handling with observable states and actions.
- **Unit Testing**: Comprehensive test coverage for all features and actions.

## Project Structure

### MyYogaCore

Contains the YogaAPIClient and necessary models to abstract that aspect away from the core TCA project. Like any modular package, this doesn't assume implementation details from the `client` (in this case the MyYogaPlan) app.

Uses the open source API from this [GitHub repo](https://github.com/alexcumplido/yoga-api)

### Main Features

1. **YogaCategoriesFeature**
    - **State**: Manages the state of yoga categories including loading and displaying categories.
    - **Action**: Defines actions related to loading categories and handling responses.
    - **Reducer**: Handles state transitions based on actions.
    - **Tests**: Ensures correct loading and handling of yoga categories.

2. **FavoritePosesFeature**
    - **State**: Manages favorite yoga poses with persistence.
    - **Action**: Defines actions for favoriting poses and loading favorites.
    - **Reducer**: Handles adding/removing poses from favorites and state persistence.
    - **Tests**: Ensures correct handling of favorite poses.

3. **AppFeature**
    - **State**: Combines states from multiple features.
    - **Action**: Defines actions to delegate to respective features.
    - **Reducer**: Scopes actions to appropriate feature reducers.
    - **Tests**: Ensures correct integration and delegation of actions to features.

## Getting Started

### Prerequisites

- Xcode 15 or later
- Swift 5.9 or later

### Dependencies
[The Composable Architecture V1.11.1](https://github.com/pointfreeco/swift-composable-architecture)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/YogaApp.git
```

2. Navigate to the project directory:
```bash
cd YogaApp
```

3. Open the project in Xcode:
```bash
open YogaApp.xcodeproj
```
### Running the App

Select the target device or simulator.
Build and run the project using the Cmd+R shortcut or the play button in Xcode.

### Running Tests
To run all tests, use the Cmd+U shortcut or navigate to Product > Test in Xcode.
Ensure all tests pass to verify the correctness of the application's functionality.

## Testing

### YogaCategoriesFeature Tests
- Load Categories: Ensures categories are loaded and state is updated.
- Error Handling: Ensures errors are handled gracefully and state is updated.

### FavoritePosesFeature Tests
- Add/Remove Favorite: Ensures poses are correctly added/removed from favorites.
- Load Favorites: Ensures favorites are loaded and state is updated.

### AppFeature Tests
- Integration: Ensures actions are correctly delegated to feature reducers and state is updated.
Conclusion

This project demonstrates my ability to develop modular and scalable iOS applications using The Composable Architecture. 

It showcases clean architecture, state management, and comprehensive testing to ensure robust and maintainable code.
