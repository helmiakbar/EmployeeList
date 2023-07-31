//
//  AddEmployeeAssembly.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import Swinject

class AddEmployeeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkProtocol.self) { r in
            return NetworkProvider()
        }
        
        container.register(AddEmployeeDataSource.self) { r in
            guard let dataProvider = r.resolve(NetworkProtocol.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return AddEmployeeRepository(remoteData: dataProvider)
        }

        container.register(AddEmployeeViewModel.self) { r in
            guard let dataSource = r.resolve(AddEmployeeDataSource.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return AddEmployeeViewModel(dataSource: dataSource)
        }
    }
}
