//
//  RemoteUserDataSource.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

protocol RemoteUserDataSource {
    func fetchUsersNameFromApi() async throws -> String
}

class RemoteUserDataSourceImpl: RemoteUserDataSource {
    func fetchUsersNameFromApi() async throws -> String {
        try await Task.sleep(for: .seconds(1))
        return "API Simulated From RemoteUserDataSource"
    }
}
