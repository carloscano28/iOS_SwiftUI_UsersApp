//
//  UserNameView.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

import SwiftUI

struct UserNameView: View {
    @StateObject var viewModel: UserViewModelState

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                ProgressView("Loading user name...")
            } else {
                Text(viewModel.username)
                    .font(.title)
                    .foregroundColor(.blue)
            }
        }
        .onAppear {
            viewModel.loadUser()
        }
        .padding()
    }
}
