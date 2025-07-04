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

    func getUsers() async throws -> [User] {
        do {
            let users = try await remoteDataSource.fetchUsersFromApi()
            try? localDataSource.saveUsers(users) // Save locally, ignore failure
            return users
        } catch {
            // On error, fallback to local cache
            return try localDataSource.getCachedUsers()
        }
    }
}

