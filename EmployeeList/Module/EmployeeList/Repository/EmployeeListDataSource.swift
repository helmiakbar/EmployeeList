//
//  EmployeeListDataSource.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import RxSwift

protocol EmployeeListDataSource {
    func getEmployeeList() -> Observable<EmployeeResponse?>
    func deleteEmployee(request: EmployeeDeleteRequestModel) -> Observable<EmployeeDeleteResponse?>
}
