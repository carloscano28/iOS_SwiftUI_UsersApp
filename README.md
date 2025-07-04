
# 📱 iOS DemoCleanArchitectureMVVM – SwiftUI + async/await + Swinject.

This project implements Clean Architecture for an iOS app using SwiftUI, async/await, Swinject, and an external API to fetch users.

---

## 🧱 Architecture Overview

The architecture follows Clean Architecture principles with clear separation of concerns:

```
Domain/
├── Entities/ # e.g., User
├── Repositories/ # UserRepository
└── UseCases/ # GetUserListUseCase

Data/
├── DataSources/ # LocalUserDataSource, # RemoteUserDataSource (uses URLSession)
├── DTOs/ # UserDTO
└── Repositories/ # UserRepositoryImpl

Presentation/
├── ViewModels/ # UserListViewModel
├── Views/ # UserListView, UserDetailView
└── Common/ # ViewState<T>

DI/
└── AppContainer.swift # Swinject setup
```

---


## 📦 Tech Stack

| Tech         | Purpose                                      |
|--------------|----------------------------------------------|
| Swift        | Language                                     |
| SwiftUI      | UI layer                                     |
| async/await  | Concurrency                                  |
| Swinject     | Dependency Injection                         |
| URLSession   | Networking                                   |
| jsonplaceholder.typicode.com | Public API                   |
| UserDefaults | Persistence                                  |

---

## 🔄 Features

```
✅ Clean Architecture with UseCases and Repositories
✅ Decoupled layers (data, domain, presentation)
✅ ViewState<T> to represent UI state (loading, success, error)
✅ UserListView with NavigationStack and UserDetailView

```

---


## 📡 API Used


https://jsonplaceholder.typicode.com/users

Returns an array of users with id, name, email.

---

## 📱 UI Flow

```
UserListView
└── shows loading or user list
└── on tap → navigates to UserDetailView
└── on error → shows error message 
```

---


## 🧪 ViewState Definition

```swift
enum ViewState<T> {
    case loading
    case success(data: T)
    case error(message: String)
}

Used in @Published var state: ViewState<[User]> inside the ViewModel.
```

---

## 🧩 Dependency Injection

The project uses Swinject via AppContainer.swift:
```
container.register(UserRepository.self) { ... }
container.register(GetUserListUseCase.self) { ... }
container.register(UserViewModelState.self) { ... }
```

---


## 💾 Persistence (UserDefaults-based cache)

The app implements local caching for offline support using `UserDefaults`.  

**Repository strategy:**
1. Tries to fetch fresh data from the remote API.
2. On success, it saves the result to local storage.
3. On failure (e.g., no internet), it loads the last saved data from local cache.

This "fallback" or "cache-as-backup" logic is fully abstracted in the repository, and does not affect ViewModels or UseCases.

---

## 🧩 Data Transfer Objects (DTOs)

To improve separation of concerns and follow Clean Architecture principles, a UserDTO was introduced in the data layer.
```
import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let email: String

    func toDomain() -> User {
        return User(id: id, name: name, email: email)
    }
}
```

- UserDTO is responsible for decoding API responses.

- It includes a toDomain() method that converts the DTO into a User domain entity.

- This approach decouples the network data model from the domain model, making the codebase more modular, testable, and maintainable.

---

## ▶️ Getting Started


1.- Clone the repo

2.- Open in Xcode 15+

3.- Switch to swiftui_view branch

3.- Build and run

It fetches users from the API and displays them in a list

---

## 🔌 Simulation Mode

🧪 Error Simulation Scenarios

The app supports simulating offline mode and cache read failures using internal flags in the data source implementations. This helps test fallback behavior and offline UX without needing to actually disconnect from the network.

🔧 Configuration
You can toggle error simulation inside AppContainer.swift:
```
// Remote (simulate HTTP/network failure)
let remote = RemoteUserDataSourceImpl()
remote.shouldSimulateError = true

// Local (simulate cache corruption or read failure)
let local = LocalUserDataSourceImpl()
local.shouldSimulateError = false
```
🧬 Supported Scenarios
| Scenario            | Remote Error | Local Error | Result in UI                           |
| ------------------- | ------------ | ----------- | -------------------------------------- |
| ✅ Normal behavior   | ❌ No         | ❌ No        | Loads fresh users from API             |
| 🌐 Offline fallback | ✅ Yes        | ❌ No        | Loads cached users (from UserDefaults) |
| ❌ No data available | ✅ Yes        | ✅ Yes       | Shows error message                    |

This fallback logic is handled transparently in the repository layer and allows you to verify how the app responds visually under unreliable network or storage conditions.

---

## 🧪 Coming Soon
```
 - Unit tests for UseCase and ViewModel
 - ErrorView and LoadingView components
 - Dependency inversion for URLSession (mockable)
 - Add error handling and retry via Alert
 - CreateUser (POST) use case

```

---


## 👨‍💻 Author


Carlos Roberto Cano Noguera

iOS & Android Developer focused on Clean Architecture and scalable design.

GitHub: @carloscano28 

LinkedIn Profile: https://www.linkedin.com/in/carlos-c-bb3a2b316/


---
