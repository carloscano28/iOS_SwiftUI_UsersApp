//
//  UserRepository.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

protocol UserRepository{
    func getUserName() async throws -> String
}
