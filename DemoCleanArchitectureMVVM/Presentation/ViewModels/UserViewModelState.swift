//
//  UserViewModelState.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

import Foundation

class UserViewModelState: ObservableObject {
    @Published var state: ViewState<[User]> = .loading
    @Published var isFromCache: Bool = false

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
                let response = try await getUserListUseCase.execute()
                await MainActor.run {
                    isFromCache = (response.source == .cache)
                    self.state = .success(data: response.users)
                }
            } catch {
                await MainActor.run {
                    self.state = .error(message: error.localizedDescription)
                }
            }
        }
    }
}
