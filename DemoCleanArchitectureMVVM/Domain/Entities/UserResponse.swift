//
//  UserResponse.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 04/07/25.
//

/// Represents the result of a user fetch operation and its data source
enum DataSourceType {
    case remote
    case cache
}

/// Wrapper that includes the user list and the origin of the data
struct UserResponse {
    let users: [User]
    let source: DataSourceType
}
