//
//  User.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 29/06/25.
//

struct User: Identifiable, Codable, Equatable{
    let id: Int
    let name: String
    let email: String
}
