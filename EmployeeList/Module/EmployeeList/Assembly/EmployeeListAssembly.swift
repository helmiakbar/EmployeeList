//
//  EmployeeListAssembly.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import Swinject

class EmployeeListAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkProtocol.self) { r in
            return NetworkProvider()
        }
        
        container.register(EmployeeListDataSource.self) { r in
            guard let dataProvider = r.resolve(NetworkProtocol.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return EmployeeListRepository(remoteData: dataProvider)
        }

        container.register(EmployeeListViewModel.self) { r in
            guard let dataSource = r.resolve(EmployeeListDataSource.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return EmployeeListViewModel(dataSource: dataSource)
        }
    }
}
