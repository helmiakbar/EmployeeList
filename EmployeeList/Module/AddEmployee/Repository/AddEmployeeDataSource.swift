//
//  AddEmployeeDataSource.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import RxSwift

protocol AddEmployeeDataSource {
    func addEmployee(request: AddEmployeeRequestModel) -> Observable<AddEmployeeResponseModel?>
    func updateEmployee(request: UpdateEmployeeRequestModel) -> Observable<AddEmployeeResponseModel?>
}
