//
//  EmployeeDeleteRequestModel.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

struct EmployeeDeleteRequestModel {
    var id: Int? = 0
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        params["id"] = id
        return params
    }
}
