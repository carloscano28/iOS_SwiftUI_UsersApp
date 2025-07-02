//
//  RemoteUserDataSource.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//
import Foundation

protocol RemoteUserDataSource {
    func fetchUsersFromApi() async throws -> [User]
}

class RemoteUserDataSourceImpl: RemoteUserDataSource {
    func fetchUsersFromApi() async throws -> [User] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)  else {
            throw URLError(.badServerResponse)
        }
        
        let userDTOs = try JSONDecoder().decode([UserDTO].self, from: data)
        return userDTOs.map { $0.toDomain() }
    }
}
