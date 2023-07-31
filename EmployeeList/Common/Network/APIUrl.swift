//
//  APIUrl.swift
//  EmployeeList
//
//  Created by PT Phincon on 29/07/23.
//

import Foundation

enum APIUrl {
    case create
    case list
    case update(requst: UpdateEmployeeRequestModel)
    case delete(requst: EmployeeDeleteRequestModel)
    
    func apiString() -> String {
        switch self {
        case .create:
            return "create"
        case .list:
            return "employees"
        case .update(let request):
            return "employee/update/\(request.id ?? 0)"
        case .delete(let request):
            return "employee/delete/\(request.id ?? 0)"
        }
    }
    
    func urlString() -> String {
        return NetworkConfiguration.api(self)
    }
}
