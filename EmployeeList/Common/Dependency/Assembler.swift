//
//  Assembler.swift
//  EmployeeList
//
//  Created by PT Phincon on 29/07/23.
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            AddEmployeeAssembly(),
            EmployeeListAssembly()
        ], container: container)
        return assembler
    }()
    
}
