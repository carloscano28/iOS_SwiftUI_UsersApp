//
//  LocalUserDataSource.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 02/07/25.
//

import Foundation

/// Protocol for accessing cached user data
protocol LocalUserDataSource {
    func saveUsers(_ users: [User]) throws
    func getCachedUsers() throws -> [User]
}

/// Default implementation of LocalUserDataSource using UserDefaults
class LocalUserDataSourceImpl: LocalUserDataSource {
    private let key = "cached_users"

    /// Simulate error reading from cache (for testing purposes)
    var shouldSimulateError: Bool = false
    
    /// Save users to local cache using UserDefaults
    func saveUsers(_ users: [User]) throws {
        let data = try JSONEncoder().encode(users)
        UserDefaults.standard.set(data, forKey: key)
    }

    /// Retrieve cached users, or throw if error is simulated
    func getCachedUsers() throws -> [User] {
        // Simulate offline/error scenario in local layer
        if shouldSimulateError {
            throw NSError(domain: "LocalCache", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Failed to load local cache (simulated)"
            ])
        }
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        return try JSONDecoder().decode([User].self, from: data)
    }
}
