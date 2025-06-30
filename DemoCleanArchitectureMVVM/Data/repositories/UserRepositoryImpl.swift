//
//  UserRepositoryImpl.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

class UserRepositoryImpl: UserRepository {
    private let remoteDataSource: RemoteUserDataSource
    
    init(remoteDataSource: RemoteUserDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getUsers() async throws -> [User] {
        return try await remoteDataSource.fetchUsersFromApi()
    }
    
}
