//
//  AppContainer.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 24/06/25.
//

import Swinject

class AppContainer {
    
    static let shared = AppContainer()
    let container: Container
    
    private init() {
        container = Container()
        
        // DataSources
        container.register(RemoteUserDataSource.self) { _ in
            RemoteUserDataSourceImpl()
        }
        
        // Repository
        container.register(UserRepository.self) { r in
            UserRepositoryImpl(remoteDataSource: r.resolve(RemoteUserDataSource.self)!)
        }
        
        // UseCases
        container.register(GetUserNameUseCase.self) { r in
            GetUserNameUseCase(repository: r.resolve(UserRepository.self)!)
        }
        
        // ViewModel para SwiftUI
        container.register(UserViewModelState.self) { r in
            UserViewModelState(getUserNameUseCase: r.resolve(GetUserNameUseCase.self)!)
        }
                
    }
    
}
