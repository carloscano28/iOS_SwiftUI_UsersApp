//
//  UserDTO.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 02/07/25.
//

import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let email: String

    func toDomain() -> User {
        return User(id: id, name: name, email: email)
    }
}
