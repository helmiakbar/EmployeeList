//
//  Dictionary+Extension.swift
//  EmployeeList
//
//  Created by PT Phincon on 29/07/23.
//

import Foundation

extension Dictionary {
    func toQueryString() -> String {
        var queryString: String = ""
        for (key,value) in self {
            queryString += "\(key)=\(value)&"
        }
        return String(queryString.dropLast())
    }
}
