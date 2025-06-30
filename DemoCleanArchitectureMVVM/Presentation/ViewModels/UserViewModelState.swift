//
//  UserViewModelState.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

import Foundation

class UserViewModelState: ObservableObject {
    @Published var state: ViewState<[User]> = .loading

    private let getUserListUseCase: GetUserListUseCase

    init(getUserListUseCase: GetUserListUseCase) {
        self.getUserListUseCase = getUserListUseCase
    }

    func loadUsers() {
        Task {
            await MainActor.run {
                self.state = .loading
            }

            do {
                let users = try await getUserListUseCase.execute()
                await MainActor.run {
                    self.state = .success(data: users)
                }
            } catch {
                await MainActor.run {
                    self.state = .error(message: error.localizedDescription)
                }
            }
        }
    }
}
