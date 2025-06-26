📱 iOS Clean Architecture Base (SwiftUI + async/await + Swinject)
This project is a modular SwiftUI-based iOS app implementing Clean Architecture, using modern concurrency (async/await) and dependency injection with Swinject.

---

🧱 Architecture Overview
The architecture follows the Clean Architecture principles, promoting separation of concerns, testability, and scalability.


Project Structure

├── Domain
│ ├── repositories/ # Protocols defining business rules
│ └── usecases/ # Use cases orchestrating domain logic
├── Data
│ ├── datasources/ # Concrete data sources (e.g., API)
│ └── repositories/ # Repository implementations
├── Presentation
│ ├── viewmodels/ # SwiftUI-compatible ViewModels
│ └── views/ # SwiftUI views
├── DI
│ └── AppContainer.swift # Dependency injection setup

---

🚀 Technologies Used
| Technology      | Purpose                                |
|----------------|------------------------------------------|
| Swift       | Primary language                        |
| SwiftUI     | Declarative UI framework                |
| Swinject    | Dependency Injection container          |
| async/await | Modern Swift concurrency model          |
| Clean Arch  | Layered project structure               |

---

🧠 Key Features
✅ Scalable, testable Clean Architecture structure
✅ SwiftUI with @StateObject and ObservableObject
✅ Asynchronous logic using async/await
✅ Swinject-based DI container
✅ ViewModel is fully decoupled from data layer

---

📂 Example Flow
UserView → UserViewModelState → GetUserNameUseCase → UserRepository → RemoteDataSource

Simulated API returns a fake user after a delay:

```swift
Carlos Cano from fake remote API (async)

🚧 Potential Improvements
 Connect to a real REST API using URLSession or Alamofire

 Add persistence layer (e.g., UserDefaults, CoreData, Realm)

 Add unit tests using XCTest with mocks

 Use a unified ViewState to represent loading, success, and error

 Replace string-based result with a model (User struct)

 Support multi-feature navigation and app-wide composition

💡 How to Use
Once you clone the repo, make sure dependencies are resolved:

Clean the project (Shift + Cmd + K)

Go to File > Packages > Resolve Package Versions

Build and run the project on simulator or device

📸 Preview (Optional)
Add a screenshot or a short GIF here showing the SwiftUI app in action.

📄 License
MIT License

👨‍💻 Author
Carlos Cano
iOS & Android Developer focused on Clean Architecture and scalable design.
GitHub: carloscano28 
LinkedIn Profile: https://www.linkedin.com/in/carlos-c-bb3a2b316/
