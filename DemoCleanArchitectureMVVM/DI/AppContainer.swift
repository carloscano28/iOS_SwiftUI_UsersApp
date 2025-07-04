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
        /*container.register(RemoteUserDataSource.self) { _ in
            RemoteUserDataSourceImpl()
        }*/
        container.register(RemoteUserDataSource.self) { _ in
            let ds = RemoteUserDataSourceImpl()
            ds.shouldSimulateError = false // Set to true for testing offline
            return ds
        }
        
        container.register(LocalUserDataSource.self) { _ in
                    LocalUserDataSourceImpl()
        }
        
        // Repository
        container.register(UserRepository.self) { r in
            UserRepositoryImpl(
                remoteDataSource: r.resolve(RemoteUserDataSource.self)!,
                localDataSource: r.resolve(LocalUserDataSource.self)!
            )
        }
        
        // UseCases
        container.register(GetUserListUseCase.self) { r in
            GetUserListUseCase(repository: r.resolve(UserRepository.self)!)
        }
        
        // ViewModel
        container.register(UserViewModelState.self) { r in
            UserViewModelState(getUserListUseCase: r.resolve(GetUserListUseCase.self)!)
        }
                
    }
    
}
