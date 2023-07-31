//
//  EmployeeListViewModel.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import RxCocoa
import RxSwift

class EmployeeListViewModel: BaseViewModel {
    private let dataSource: EmployeeListDataSource
    private var employeeData: EmployeeResponse?
    var deleteEmployeeState = BehaviorRelay<LoadingState>(value: .notLoad)
    
    init(dataSource: EmployeeListDataSource) {
        self.dataSource = dataSource
    }
    
    func getEmployeeCount() -> Int {
        return employeeData?.data?.count ?? 0
    }
    
    func getEmployee(_ index: Int) -> EmployeeResponse.Employee? {
        if let validData = employeeData, let validEmployee = validData.data {
            return validEmployee[index]
        }
        return nil
    }
    
    func loadEmployee() {
        state.accept(.loading)
        dataSource.getEmployeeList()
            .subscribe(onNext: { [weak self] responseModel in
                self?.employeeData = responseModel
                self?.state.accept(.finished)
            }, onError: { [weak self] error in
                self?.handleNetworkError(error)
                self?.state.accept(.failed)
            })
            .disposed(by: disposeBag)
    }
    
    func deleteEmployee(_ employee: EmployeeResponse.Employee?) {
        var request = EmployeeDeleteRequestModel()
        if let validEmployee = employee {
            request = EmployeeDeleteRequestModel(id: validEmployee.id)
        }
        deleteEmployeeState.accept(.loading)
        dataSource.deleteEmployee(request: request)
            .subscribe(onNext: { [weak self] responseModel in
                self?.deleteEmployeeState.accept(.finished)
            }, onError: { [weak self] error in
                self?.handleNetworkError(error)
                self?.deleteEmployeeState.accept(.failed)
            })
            .disposed(by: disposeBag)
    }
}
