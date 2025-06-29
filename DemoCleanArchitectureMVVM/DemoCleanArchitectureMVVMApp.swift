//
//  DemoCleanArchitectureMVVMApp.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

import SwiftUI

@main
struct DemoCleanArchitectureMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = AppContainer.shared.container.resolve(UserViewModelState.self)!
            UserNameView(viewModel: viewModel)
        }
    }
}
