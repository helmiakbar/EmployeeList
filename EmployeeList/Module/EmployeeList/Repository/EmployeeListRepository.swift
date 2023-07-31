//
//  EmployeeListRepository.swift
//  EmployeeList
//
//  Created by PT Phincon on 31/07/23.
//

import RxSwift

class EmployeeListRepository: EmployeeListDataSource {
    private let remoteData: NetworkProtocol
    
    init(remoteData: NetworkProtocol) {
        self.remoteData = remoteData
    }
    
    func getEmployeeList() -> Observable<EmployeeResponse?> {
        let url = APIUrl.list.urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        return remoteData.get(url: urlString).flatMap { data -> Observable<EmployeeResponse?> in
            do {
                let responseModel = try JSONDecoder().decode(EmployeeResponse.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    
    func deleteEmployee(request: EmployeeDeleteRequestModel) -> Observable<EmployeeDeleteResponse?> {
        let url = APIUrl.delete(requst: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        return remoteData.delete(url: urlString).flatMap { data -> Observable<EmployeeDeleteResponse?> in
            do {
                let responseModel = try JSONDecoder().decode(EmployeeDeleteResponse.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
}
