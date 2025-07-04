//
//  UserNameView.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject var viewModel: UserViewModelState
    @State private var selectedUser: User?

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Users")
                .navigationDestination(isPresented: Binding<Bool>(
                    get: { selectedUser != nil },
                    set: { if !$0 { selectedUser = nil } }
                )) {
                    if let user = selectedUser {
                        UserDetailView(user: user)
                    }
                }
                .onAppear {
                    viewModel.loadUsers()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading...")

        case .success(let users):
            VStack {
                if viewModel.isFromCache {
                    Text("Showing offline data")
                        .font(.caption)
                        .foregroundColor(.orange)
                }

                List(users) { user in
                    Button(action: {
                        selectedUser = user
                    }) {
                        VStack(alignment: .leading) {
                            Text(user.name).font(.headline)
                            Text(user.email).font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }
            }

            

        case .error(let message):
            Text("Error: \(message)").foregroundColor(.red)
        }
    }
}



struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Success state with cache indicator
            let users = [
                User(id: 1, name: "Carlos Cano", email: "carlos@example.com"),
                User(id: 2, name: "Jane Doe", email: "jane@example.com")
            ]
            UserListView(viewModel: MockUserListViewModel(state: .success(data: users), isFromCache: true))
                .previewDisplayName("Success (from cache)")

            // Loading state
            UserListView(viewModel: MockUserListViewModel(state: .loading, isFromCache: false))
                .previewDisplayName("Loading")

            // Error state
            UserListView(viewModel: MockUserListViewModel(state: .error(message: "No internet connection"), isFromCache: false))
                .previewDisplayName("Error")
        }
    }

    /// Mock ViewModel that supports all ViewState cases
    class MockUserListViewModel: UserViewModelState {
        init(state: ViewState<[User]>, isFromCache: Bool) {
            super.init(getUserListUseCase: DummyUseCase())
            self.state = state
            self.isFromCache = isFromCache
        }

        /// Dummy use case for SwiftUI preview context
        class DummyUseCase: GetUserListUseCase {
            init() {
                super.init(repository: DummyRepository())
            }

            override func execute() async throws -> UserResponse {
                return UserResponse(users: [], source: .remote)
            }

            class DummyRepository: UserRepository {
                func getUsers() async throws -> UserResponse {
                    return UserResponse(users: [], source: .remote)
                }
            }
        }

        override func loadUsers() {
            // Do nothing in preview
        }
    }
}
