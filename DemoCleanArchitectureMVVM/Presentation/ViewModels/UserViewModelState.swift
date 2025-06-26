//  UserViewModelState.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

import Foundation

//@MainActor
class UserViewModelState: ObservableObject {
    @Published var username: String = ""
    @Published var isLoading: Bool = false

    private let getUserNameUseCase: GetUserNameUseCase

    init(getUserNameUseCase: GetUserNameUseCase) {
        self.getUserNameUseCase = getUserNameUseCase
    }

    func loadUser() {
        Task {
            // Enable loading
            await MainActor.run {
                self.isLoading = true
            }

            do {
                let name = try await getUserNameUseCase.execute()

                // Update username on the main thread
                await MainActor.run {
                    self.username = name
                }
            } catch {
                await MainActor.run {
                    self.username = "Error: (error.localizedDescription)"
                }
            }

            // Disable loading
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
}
