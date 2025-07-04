//
//  LocalUserDataSource.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 02/07/25.
//

import Foundation

protocol LocalUserDataSource {
    func saveUsers(_ users: [User]) throws
    func getCachedUsers() throws -> [User]
}

class LocalUserDataSourceImpl: LocalUserDataSource {
    private let key = "cached_users"

    func saveUsers(_ users: [User]) throws {
        let data = try JSONEncoder().encode(users)
        UserDefaults.standard.set(data, forKey: key)
    }

    func getCachedUsers() throws -> [User] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        return try JSONDecoder().decode([User].self, from: data)
    }
}
