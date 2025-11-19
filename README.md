# E-Commerce Flutter App

A Flutter e-commerce application demonstrating user authentication (login/register) with a modern Material Design 3 UI. Built using MVVM architecture with GetX for state management.

## Tech Stack

- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **GetX** - State management, routing, and dependency injection
- **HTTP** - REST API communication
- **Material Design 3** - Modern UI design system

---

## Installation & Setup

### Prerequisites

1. **Flutter SDK** (3.0 or higher)
   ```bash
   # Check Flutter installation
   flutter doctor
   ```

2. **Android Studio** with Android SDK and emulator configured

3. **Git** for version control

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone git@github.com:jxnhoongz/ecom_flutter_y4s2.git
   cd ecom_flutter_y4s2
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Start Android emulator**
   ```bash
   # List available emulators
   flutter emulators

   # Launch emulator
   flutter emulators --launch <emulator_name>
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Common Issues & Fixes

**Gradlew permission error (macOS):**
```bash
chmod +x android/gradlew
xattr -d com.apple.quarantine android/gradlew
```

**NDK version issues:**
If you see NDK-related errors, check `android/app/build.gradle.kts` and ensure the NDK version matches what's installed in your Android SDK.

**Clean build:**
```bash
flutter clean
flutter pub get
flutter run
```

---

## Project Structure

```
lib/
├── app/
│   └── my_app.dart              # Main app configuration, theme, routes
├── models/
│   ├── Request/
│   │   ├── Login_request.dart   # Login request model
│   │   └── Register_request.dart # Register request model
│   ├── response/
│   │   ├── Login_response.dart  # Login response with access token
│   │   └── User.dart            # User data model
│   └── api_base_response.dart   # Generic API response wrapper
├── modules/
│   ├── home/
│   │   ├── view/
│   │   │   └── home_view.dart   # Home screen UI
│   │   └── view_mode/
│   │       └── home_view_model.dart
│   ├── login/
│   │   ├── view/
│   │   │   └── login_view.dart  # Login screen UI
│   │   └── view_model/
│   │       └── login_view_model.dart
│   ├── register/
│   │   ├── view/
│   │   │   └── register_view.dart
│   │   └── view_model/
│   │       └── register_view_model.dart
│   └── splash/
│       └── ...
├── repository/
│   ├── auth_repository.dart     # Abstract interface
│   └── auth_repositoryImpl.dart # Concrete implementation
├── service/
│   ├── constant_uri.dart        # API endpoints
│   └── remote_service_impl.dart # HTTP client
└── widgets/
    └── auth/
        ├── auth_button.dart     # Reusable button widgets
        └── auth_text_field.dart # Reusable text field widgets
```

---

## Architecture: MVVM Pattern

This app uses **MVVM (Model-View-ViewModel)** architecture to separate concerns and make the code maintainable.

### Why MVVM?

1. **Separation of Concerns** - UI logic is separate from business logic
2. **Testability** - ViewModels can be unit tested without UI
3. **Reusability** - Models and ViewModels can be reused across different views
4. **Maintainability** - Easy to modify one layer without affecting others

### Layer Breakdown

#### 1. View (UI Layer)
**Location:** `lib/modules/*/view/`

- Responsible for displaying UI elements
- Contains no business logic
- Observes ViewModel state changes using `Obx()`
- Calls ViewModel methods for user actions

```dart
// Example from login_view.dart
Obx(() {
  return AuthTextField(
    controller: loginViewModel.usernameController.value,
    onChanged: loginViewModel.onChangeValueUsername,
  );
})
```

#### 2. ViewModel (Presentation Logic)
**Location:** `lib/modules/*/view_model/`

- Contains UI-related business logic
- Manages reactive state with `.obs` variables
- Validates user input
- Calls Repository methods for data operations
- Extends `GetxController` for lifecycle management

```dart
// Example from login_view_model.dart
class LoginViewModel extends GetxController {
  var username = "".obs;  // Reactive variable
  var password = "".obs;

  onLogin() async {
    // Validation
    if(username.isEmpty) {
      showMassageError("Username is required.");
      return;
    }

    // Call repository
    var loginRes = await authRepository.login(username.value, password.value);

    // Handle response
    if(loginRes.accessToken != null) {
      Get.offAllNamed("/");  // Navigate to home
    }
  }
}
```

#### 3. Model (Data Layer)
**Location:** `lib/models/`

- Plain Dart classes representing data structures
- Contains `fromJson()` and `toJson()` methods for serialization
- No business logic

```dart
// Example: Register_request.dart
class RegisterRequest {
  String? username;
  String? email;
  String? password;
  // ... other fields

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
```

#### 4. Repository (Data Abstraction)
**Location:** `lib/repository/`

- Abstract interface defining data operations
- Concrete implementation handles actual API calls
- Converts raw API responses to domain models

```dart
// Abstract interface
abstract class AuthRepository {
  Future<LoginResponse> login(String username, String password);
  Future<ApiBaseResponse> register(...);
}

// Concrete implementation
class AuthRepositoryImpl implements AuthRepository {
  final serviceApi = RemoteServiceImpl();

  @override
  Future<LoginResponse> login(String username, String password) async {
    var response = await serviceApi.postApi(
      uri: ConstantUri.loginPath,
      body: jsonEncode(LoginRequest(
        phoneNumber: username,
        password: password
      ).toJson())
    );

    if(response.isSuccess == true) {
      return LoginResponse.fromJson(jsonDecode(response.data));
    }
    return LoginResponse();
  }
}
```

#### 5. Service (Network Layer)
**Location:** `lib/service/`

- Handles raw HTTP communication
- Sets headers, timeout, content type
- Returns generic `ApiBaseResponse`

```dart
// remote_service_impl.dart
Future<ApiBaseResponse> postApi({required String uri, required String body}) async {
  var response = await http.post(
    Uri.parse(ConstantUri.baseUri + uri),
    headers: {"Content-Type": "application/json"},
    body: body,
  ).timeout(Duration(seconds: 120));

  if(response.statusCode == 200 || response.statusCode == 201) {
    responseBody.isSuccess = true;
    responseBody.data = response.body;
  } else {
    responseBody.isSuccess = false;
  }
  return responseBody;
}
```

---

## Authentication Flow

### API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/oauth/token` | POST | User login |
| `/api/oauth/register` | POST | User registration |

**Base URL:** `https://learn-api.cambofreelance.com`

### Login Flow

1. **User enters credentials** in `login_view.dart`
2. **View calls ViewModel** method `onLogin()`
3. **ViewModel validates** input (empty checks)
4. **ViewModel calls Repository** `authRepository.login()`
5. **Repository calls Service** `serviceApi.postApi()`
6. **Service makes HTTP POST** to `/api/oauth/token`
7. **API returns response** with `accessToken`
8. **Response flows back** through layers
9. **ViewModel checks** if `accessToken` exists
10. **Navigate to home** on success, show error on failure

```
User Input → View → ViewModel → Repository → Service → API
                                                        ↓
Home Screen ← View ← ViewModel ← Repository ← Service ← Response
```

### Login Request Format
```json
{
  "phoneNumber": "user_phone_number",
  "password": "user_password"
}
```

### Login Response Format
```json
{
  "access_token": "eyJhbGciOiJIUzI1...",
  "token_type": "bearer",
  "refresh_token": "...",
  "expires_in": 43199,
  "user": {
    "id": 1,
    "username": "john",
    "email": "john@example.com"
  }
}
```

### Register Flow

Similar to login, but:
1. More fields required (username, firstName, lastName, email, phoneNumber, password)
2. Returns success message instead of access token
3. On success, navigates back to login page

### Register Request Format
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "username": "johndoe",
  "email": "john@example.com",
  "phoneNumber": "0123456789",
  "password": "password123",
  "confirmPassword": "password123",
  "profile": "NON",
  "role": "USER"
}
```

### Register Response Format
```json
{
  "message": "Create Success",
  "code": "200",
  "data": "User Open Account successfully!"
}
```

---

## State Management: GetX

### Why GetX?

1. **Simple reactive state** - Just add `.obs` to make variables reactive
2. **No boilerplate** - Less code compared to Provider or Bloc
3. **Built-in routing** - Named routes with `Get.toNamed()`
4. **Dependency injection** - `Get.put()` for controllers

### Key Concepts

#### Reactive Variables (`.obs`)

```dart
var username = "".obs;  // Creates an Rx<String>
var isLoading = false.obs;  // Creates an Rx<bool>
```

#### Observing Changes (`Obx`)

```dart
// Automatically rebuilds when username changes
Obx(() => Text(viewModel.username.value))
```

#### Updating Values

```dart
username.value = "new_value";  // Triggers UI rebuild
```

#### Navigation

```dart
// Navigate to named route
Get.toNamed("/login");

// Navigate and clear stack (can't go back)
Get.offAllNamed("/");

// Navigate to widget
Get.to(() => RegisterView());

// Go back
Get.back();
```

#### Dependency Injection

```dart
// Register controller
var viewModel = Get.put(LoginViewModel());

// Access anywhere
var vm = Get.find<LoginViewModel>();
```

---

## UI/UX Design Choices

### Material Design 3

Using Flutter's Material 3 design system for:
- Modern, clean aesthetics
- Consistent component styling
- Built-in accessibility features
- Dynamic color support

### Color Scheme

**Primary Color:** Light Blue (`#03A9F4`)

Configured in `my_app.dart`:
```dart
theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF03A9F4),
    brightness: Brightness.light,
  ),
)
```

### Theme-Based Styling

Instead of hardcoding colors, we use the theme's `ColorScheme`:

```dart
final colorScheme = Theme.of(context).colorScheme;

Container(
  color: colorScheme.primary,  // Uses theme primary color
  child: Text(
    'Hello',
    style: TextStyle(color: colorScheme.onPrimary),
  ),
)
```

**Benefits:**
- Easy to change entire app theme by modifying seed color
- Consistent colors throughout the app
- Automatic contrast (e.g., `onPrimary` is always readable on `primary`)

### Reusable Widgets

Created custom widgets for consistency:

- `AuthTextField` - Styled text input with icon
- `AuthPasswordField` - Password input with show/hide toggle
- `AuthButton` - Primary action button with loading state
- `AuthTextButton` - Text link button

---

## Key Technical Terms

### Terms Your Professor Might Ask About

| Term | Explanation |
|------|-------------|
| **MVVM** | Model-View-ViewModel pattern separating UI, logic, and data |
| **GetX** | Flutter package for state management, routing, and DI |
| **Reactive Programming** | UI automatically updates when data changes |
| **Repository Pattern** | Abstraction layer between business logic and data source |
| **JSON Serialization** | Converting objects to/from JSON format |
| **REST API** | HTTP-based API using GET, POST, PUT, DELETE methods |
| **Access Token** | JWT token for authenticated API requests |
| **Material Design 3** | Google's latest design system for apps |
| **ColorScheme** | Set of colors that work together in Material Design |
| **StatelessWidget** | Widget that doesn't hold mutable state |
| **Dependency Injection** | Providing dependencies to classes from outside |

---

## Possible Interview Questions & Answers

**Q: How does your authentication work?**
> The login screen collects phone number and password, sends a POST request to the API with JSON body. The API returns an access token on success. The ViewModel checks if the token exists and navigates to home, or shows an error message.

**Q: Why did you choose MVVM?**
> MVVM separates concerns - the View handles UI, ViewModel handles presentation logic, and Repository handles data. This makes the code easier to test, maintain, and modify.

**Q: Why GetX instead of Provider or Bloc?**
> GetX requires less boilerplate code. Just add `.obs` for reactive variables and wrap with `Obx()` to observe. It also includes routing and dependency injection built-in.

**Q: How do you handle API errors?**
> The Service layer checks HTTP status codes. If it's 200 or 201, `isSuccess` is true. Otherwise, it's false. The ViewModel checks this flag and shows appropriate error messages using snackbars.

**Q: What's the Repository pattern?**
> It's an abstraction between business logic and data source. The abstract interface defines what operations are available, and the implementation handles actual API calls. This allows swapping data sources easily.

**Q: How does theming work?**
> We use Material 3's `ColorScheme.fromSeed()` with a seed color. This generates a complete color palette. Throughout the app, we reference `colorScheme.primary`, `colorScheme.surface`, etc. instead of hardcoded colors.

---

## Future Improvements

- [ ] Store access token in secure storage
- [ ] Implement refresh token logic
- [ ] Add actual product API integration
- [ ] Implement cart and checkout functionality
- [ ] Add pull-to-refresh
- [ ] Implement search functionality
- [ ] Add user profile management

---

## License

This project is for educational purposes.
