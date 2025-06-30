//
//  DemoCleanArchitectureMVVMApp.swift
//  DemoCleanArchitectureMVVM With SwiftUI
//
//  Created by Carlos R on 24/06/25.
//

import SwiftUI

@main
struct DemoCleanArchitectureMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = AppContainer.shared.container.resolve(UserViewModelState.self)!
            UserListView(viewModel: viewModel)
        }
    }
}
