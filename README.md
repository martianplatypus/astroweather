# AstroWeather

AstroWeather is a simple weather client for iOS that displays current weather information for specific cities as well as the user's current location. The app utilizes the OpenWeatherMap API to fetch and display weather details. Below, you'll find a breakdown of the features, technical details, and development insights for the project.

---

## 📋 Features (Use Cases)

AstroWeather covers the following use cases:

1. **Display Weather Information**:
   - Fetch and display weather data for:
     - User's current location.
     - Three hardcoded cities: London, Montevideo, and Buenos Aires.
   - Display:
     - City name.
     - Weather description and icon.
     - Current temperature, max temperature, and min temperature.
<img src="https://github.com/user-attachments/assets/4db4c050-7deb-4f52-a4d9-0a6e25c8f823" width=20% height=20%>
<img src="https://github.com/user-attachments/assets/e2e26176-0e98-4140-a638-cfb7dcdc7500" width=20% height=20%>

2. **Location Management**:

   - Request and handle user permissions for location access.
   - Show weather for the user's current location if permission is granted.
   - Persist the user's last selected city or current location across app launches.

<img src="https://github.com/user-attachments/assets/5c29a01b-d520-4d99-9058-1ee385218bd0" width=20% height=20%>
<img src="https://github.com/user-attachments/assets/bae301ef-54fb-4bf6-9fea-89c922cfae67" width=20% height=20%>

3. **User-Friendly Interface**:

   - View details in a clean and intuitive design using SwiftUI.
   - Switch between locations using a tab-based interface.

4. **Technical Compatibility**:
   - Supports iOS 15.5+.
   - Implements modern SwiftUI features while maintaining backward compatibility.

---

## 🚀 How to Run the App

### Prerequisites

1. Xcode 14+.
2. iOS 15.5+ device or simulator.
3. OpenWeatherMap API key.

### Setup

1. Clone the repository:
   ```bash
   git clone git@github.com:martianplatypus/astroweather.git
   cd AstroWeather
   ```
2. **Configure API Key**:

   - Create a file named `dev.xcconfig` in the root of the project (ignored by `.gitignore` for security).
   - Add the following content to `dev.xcconfig`:
     ```plaintext
     OPEN_WEATHER_API_KEY = your_api_key_here
     ```
   - Replace `your_api_key_here` with your actual OpenWeatherMap API key.

3. Open `AstroWeather.xcodeproj` in Xcode.

4. Run the app on a compatible simulator or device.

---

## 🏗️ Architecture

AstroWeather uses **MVVM + Repository** architecture to achieve modularity, testability, and separation of concerns.

### MVVM (Model-View-ViewModel)

- **Model**:

  - Represents the weather data fetched from the API.
  - Contains Codable structs like `Weather`, `WeatherDetails`, and `WeatherConditions`.

- **ViewModel**:

  - Handles business logic and API interactions.
  - Examples: `WeatherDataViewModel`, `LocationListViewModel`.
  - Maintains state like `isLoading`, `errorMessage`, and `weatherData`.
  - Acts as a bridge between the Views and Repository.

- **View**:
  - Implements SwiftUI components to display weather data.
  - Examples: `LocationListView`, `LocationRowView`, `LocationWeatherView`.

### Repository

- Centralizes data-fetching logic.
- Handles interactions with the OpenWeatherMap API.
- Example: `WeatherRepository` fetches weather data for specific cities or the user's current location.
- Ensures testability by abstracting API calls with protocols (`WeatherRepositoryRequesting`).

### Key Benefits:

- **Separation of Concerns**: Views focus on UI, ViewModels handle state and logic, and Repositories manage data.
- **Testability**: ViewModels and Repositories can be tested independently.
- **Scalability**: New features and cities can be added with minimal changes.

---

## ⚠️ Notes

- **Privacy and Security**:
  - The `dev.xcconfig` file is ignored in the repository to prevent API key exposure. Follow the setup steps above to configure your local environment.
- **Location Permissions**:
  - Ensure location services are enabled on your device.
  - The app provides a one-time prompt to request location access. If denied, the app defaults to the hardcoded cities.

---

## 📚 Future Improvements

- Abstract logic for saving user data to a dedicated layer (e.g., a `DataStore` abstraction) to avoid direct calls to `UserDefaults` in multiple places.
- Add a settings screen to enable user preferences customization, such as:
  - Switching between the imperial and metric systems.
  - Reviewing or revoking permissions (e.g., location).
  - Adjusting app behavior to suit user needs.
- Address an issue where the last seen location is not always displayed as default when the app is relaunched.
- Add support for hourly and weekly weather forecasts.
- Enhance the user interface with animations and additional details.
- Include dark mode customization.
- Optimize network error handling with retries.

---

