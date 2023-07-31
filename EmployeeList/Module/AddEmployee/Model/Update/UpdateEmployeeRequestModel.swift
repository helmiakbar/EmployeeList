//
//  UpdateEmployeeRequestModel.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import Foundation

struct UpdateEmployeeRequestModel {
    var id: Int? = 0
    var name: String? = ""
    var age: Int? = 0
    var salary: Int? = 0
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        params["id"] = id
        params["name"] = name
        params["age"] = age
        params["salary"] = salary
        return params
    }
}
