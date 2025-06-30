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

        case .error(let message):
            Text("Error: \(message)").foregroundColor(.red)
        }
    }
}



struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        let users = [
            User(id: 1, name: "Carlos Cano", email: "carlos@example.com"),
            User(id: 2, name: "Jane Doe", email: "jane@example.com"),
            User(id: 3, name: "John Doe", email: "john@example.com"),
            User(id: 4, name: "Alice Doe", email: "alice@example.com"),
            User(id: 5, name: "Bob Doe", email: "bob@example.com"),
            User(id: 6, name: "David Doe", email: "david@example.com"),
            User(id: 7, name: "Emma Doe", email: "emma@example.com"),
            User(id: 8, name: "Frank Doe", email: "frank@example.com"),
            User(id: 9, name: "Grace Doe", email: "grace@example.com"),
            User(id: 10, name: "Henry Doe", email: "henry@example.com"),
            User(id: 11, name: "Isabella Doe", email: "isabella@example.com"),
            User(id: 12, name: "Jack Doe", email: "jack@example.com"),
            User(id: 13, name: "Katherine Doe", email: "katherine@example.com"),
            User(id: 14, name: "Louis Doe", email: "louis@example.com"),
            User(id: 15, name: "Mia Doe", email: "mia@example.com"),
        ]

        let viewModel = MockUserListViewModel(users: users)
        UserListView(viewModel: viewModel)
    }

    class MockUserListViewModel: UserViewModelState {
        init(users: [User]) {
            super.init(getUserListUseCase: DummyUseCase())
            self.state = .success(data: users)
        }

        class DummyUseCase: GetUserListUseCase {
            init() {
                super.init(repository: DummyRepository())
            }

            override func execute() async throws -> [User] {
                return []
            }

            class DummyRepository: UserRepository {
                func getUsers() async throws -> [User] { return [] }
            }
        }

        override func loadUsers() {
            // do nothing
        }
    }
}

