//
//  AddEmployeeViewModel.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import RxCocoa
import RxSwift

class AddEmployeeViewModel: BaseViewModel {
    private let dataSource: AddEmployeeDataSource
    
    init(dataSource: AddEmployeeDataSource) {
        self.dataSource = dataSource
    }
    
    func AddEmployee(_ request: AddEmployeeRequestModel) {
        state.accept(.loading)
        dataSource.addEmployee(request: request)
            .subscribe(onNext: { [weak self] responseModel in
                self?.state.accept(.finished)
            }, onError: { [weak self] error in
                self?.handleNetworkError(error)
                self?.state.accept(.failed)
            })
            .disposed(by: disposeBag)
    }
    
    func updateEmployee(_ request: UpdateEmployeeRequestModel) {
        state.accept(.loading)
        dataSource.updateEmployee(request: request)
            .subscribe(onNext: { [weak self] responseModel in
                self?.state.accept(.finished)
            }, onError: { [weak self] error in
                self?.handleNetworkError(error)
                self?.state.accept(.failed)
            })
            .disposed(by: disposeBag)
    }
}
