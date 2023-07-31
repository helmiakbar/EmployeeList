//
//  ResponseErrorModel.swift
//  EmployeeList
//
//  Created by PT Phincon on 29/07/23.
//

import Foundation

struct ResponseErrorArrayModel: Codable, Error {
    var errors: [ResponseErrorModel]?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case errors, error
    }
}

struct ResponseErrorModel: Codable, Error {
    var title: String?
    var detail: String?
    var errorImageUrl: String?
    var status: NSNumber?
    var code: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case detail
        case code
    }
}

extension ResponseErrorModel {
    init(systemError: NSError) {
        self.init()
        self.status = systemError.code as NSNumber

        if systemError.code == NSURLErrorNotConnectedToInternet ||
            systemError.code == NSURLErrorNetworkConnectionLost  ||
            systemError.code == NetworkConfiguration.kGatewayTimeoutErrorCode {
            
            self.title = "Koneksi Error"
            self.detail = "Oops! Terjadi kesalahan pada server kami.Mohon coba kembali"
        } else {
            self.title = systemError.localizedDescription
            self.detail = systemError.localizedRecoverySuggestion
        }
    }
}
