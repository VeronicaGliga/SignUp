# AssesmentLHS

## Features

* **Registration Screen**: First screen shown on app start, where users can input registration details.
* **Data Validation**: Ensures form inputs meet specific criteria before allowing registration.
* **Confirmation Screen**: Displays a welcome message and list of allowed aircraft for registered users.
* **Logout Functionality**: Users can log out, returning to the registration screen and discarding registration data.

## Usage

1. Unzip archive
2. Open AssesmentLHS.xcodeproj
3. Registration Screen will display
4. Input the required information to enable Register button
5. Confirmation Screen will display
6. To logout, use Logout button the side menu

## Technologies Used

* **Swift**: For the main programming language
* **SwfftUI**: To build the UI and manage state.

## Technical Aspects

**Architecture**
 I used **MVVM** architecture because of its key aspects:
    * **Clear Separation of Concerns**
    * **Enhanced Testability**: MVVM enables isolated testing of both the Model and ViewModel. For instance, you can write unit tests to verify that validation rules in the ViewModel are correct without the need for a UI test.
    * **Data Binding**: SwiftUI provides built-in tools like @Published and @StateObject, which allow the ViewModel to notify Views of state changes automatically.
    * **Enhanced Maintainability**: Even if it is a small project it's essential to view it as a continuously growing application. 

**Testing**
For testing and maintainability, I implemented **dependency injection** and used **generic service classes** in the project. This approach allows us to isolate components, mock dependencies, and validate functionality in a controlled manner.

**Key Classes**
    * **FileStorage**: a generic data-fetching utility designed to load and decode JSON files stored within an app's bundle
    * **UserDefaultsStorage**: provides a flexible, type-safe way to store, retrieve, and delete data in UserDefaults. I used UserDefaults to store User data, because I stored only non-sensitive data. In case we'll need to create Sign In functionality in the future, we should think about other strategy like a backend connection, Oauth frameforks or Keychain.
    * **UserManager** && **PilotLicenseManager**: are designed to manage user-related or license-related data. They allow managers to use any data handler wether it is UserDefaults or a Backend Service. 
    * **AnyDataHandler** && **AnyDataFetcher**: we use type erasure to allow the use of protocol with associated types as a property type in managers.
    * **DependencyContainer**: is a central point for managing and injecting dependencies across an app.
