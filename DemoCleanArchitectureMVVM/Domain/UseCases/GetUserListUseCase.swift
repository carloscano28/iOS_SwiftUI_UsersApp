//
//  GetUserNameUseCase.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

class GetUserListUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [User] {
        return try await repository.getUsers()
    }
}
