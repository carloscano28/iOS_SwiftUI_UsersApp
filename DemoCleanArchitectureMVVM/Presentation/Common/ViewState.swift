//
//  ViewState.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 29/06/25.
//

enum ViewState<T> {
    case loading
    case success(data: T)
    case error(message: String)
}

