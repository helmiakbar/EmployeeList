//
//  AddEmployeeResponseModel.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import Foundation

struct AddEmployeeResponseModel: Codable {
    let status, message: String?
    let data: AddEmployeeData?
    
    struct AddEmployeeData: Codable {
        let name: String?
        let id, age, salary: Int?
    }
}
