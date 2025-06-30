//
//  UserNameView.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject var viewModel: UserViewModelState

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Users")
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
                VStack(alignment: .leading) {
                    Text(user.name).font(.headline)
                    Text(user.email).font(.subheadline).foregroundColor(.gray)
                }
            }

        case .error(let message):
            Text("Error: \(message)").foregroundColor(.red)
        }
    }
}
