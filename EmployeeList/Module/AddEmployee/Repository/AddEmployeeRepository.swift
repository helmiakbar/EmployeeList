//
//  AddEmployeeRepository.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import RxSwift

class AddEmployeeRepository: AddEmployeeDataSource {
    private let remoteData: NetworkProtocol
    
    init(remoteData: NetworkProtocol) {
        self.remoteData = remoteData
    }
    
    func addEmployee(request: AddEmployeeRequestModel) -> Observable<AddEmployeeResponseModel?> {
        let url = APIUrl.create.urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        return remoteData.post(url: urlString, bodyParams: request.getParams()).flatMap { data -> Observable<AddEmployeeResponseModel?> in
            do {
                let responseModel = try JSONDecoder().decode(AddEmployeeResponseModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    
    func updateEmployee(request: UpdateEmployeeRequestModel) -> Observable<AddEmployeeResponseModel?> {
        let url = APIUrl.update(requst: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        return remoteData.put(url: urlString, bodyParams: request.getParams()).flatMap { data -> Observable<AddEmployeeResponseModel?> in
            do {
                let responseModel = try JSONDecoder().decode(AddEmployeeResponseModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
}
