//
//  UserRepositoryImpl.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

class UserRepositoryImpl: UserRepository {
    private let remoteDataSource: RemoteUserDataSource
    private let localDataSource: LocalUserDataSource

    init(
        remoteDataSource: RemoteUserDataSource,
        localDataSource: LocalUserDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func getUsers() async throws -> UserResponse {
        do {
            let users = try await remoteDataSource.fetchUsersFromApi()
            try? localDataSource.saveUsers(users) // Save locally, ignore failure
            return UserResponse(users: users, source: .remote)
        } catch {
            let cached = try localDataSource.getCachedUsers()
            return UserResponse(users: cached, source: .cache)
        }
    }
}

