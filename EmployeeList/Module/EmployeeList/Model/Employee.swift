//
//  Employee.swift
//  EmployeeList
//
//  Created by PT Phincon on 30/07/23.
//

import Foundation

struct EmployeeResponse: Codable {
    let status: String?
    let data: [Employee]?
    
    struct Employee: Codable {
        let id, employeeSalary, employeeAge: Int?
        let employeeName: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case employeeName = "employee_name"
            case employeeSalary = "employee_salary"
            case employeeAge = "employee_age"
        }
    }
    
}

struct EmployeeDeleteResponse: Codable {
    let status, data, message: String?
}
