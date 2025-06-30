
📱 iOS DemoCleanArchitectureMVVM – SwiftUI + async/await + Swinject
This project implements Clean Architecture for an iOS app using SwiftUI, async/await, Swinject, and an external API to fetch users.

---

🧱 Architecture Overview
The architecture follows Clean Architecture principles with clear separation of concerns:
```
Domain/
├── Entities/ # e.g., User
├── Repositories/ # UserRepository
└── UseCases/ # GetUserListUseCase

Data/
├── DataSources/ # RemoteUserDataSource (uses URLSession)
└── Repositories/ # UserRepositoryImpl

Presentation/
├── ViewModels/ # UserListViewModel
├── Views/ # UserListView, UserDetailView
└── Common/ # ViewState<T>

DI/
└── AppContainer.swift # Swinject setup
```

---

📦 Tech Stack
| Tech         | Purpose                                      |
|--------------|----------------------------------------------|
| Swift        | Language                                     |
| SwiftUI      | UI layer                                     |
| async/await  | Concurrency                                  |
| Swinject     | Dependency Injection                         |
| URLSession   | Networking                                   |
| jsonplaceholder.typicode.com | Public API                   |

---

🔄 Features
```
✅ Clean Architecture with UseCases and Repositories
✅ Decoupled layers (data, domain, presentation)
✅ ViewState<T> to represent UI state (loading, success, error)
✅ UserListView with NavigationStack and UserDetailView
✅ Real API integration with error handling and retry via Alert
```
---

📡 API Used
https://jsonplaceholder.typicode.com/users

Returns an array of users with id, name, email.

---

📱 UI Flow
```
UserListView
└── shows loading or user list
└── on tap → navigates to UserDetailView
└── on error → shows Alert with Retry 
```
---

🧠 ViewState Example
```swift
enum ViewState<T> {
    case loading
    case success(data: T)
    case error(message: String)
}

Used in @Published var state: ViewState<[User]> inside the ViewModel.
```

---

🧪 Coming Soon

 Add persistence (CoreData)
 
 Unit tests for UseCase and ViewModel

 ErrorView and LoadingView components

 Dependency inversion for URLSession (mockable) 

---

📄 License
MIT License

---

👨‍💻 Author
Carlos Cano
iOS & Android Developer focused on Clean Architecture and scalable design.
GitHub: @carloscano28 
LinkedIn Profile: https://www.linkedin.com/in/carlos-c-bb3a2b316/

---
