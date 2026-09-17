//
//  HTTPBody.swift
//  NetworkLayer
//
import Foundation

enum HTTPBody {
    case data(Data)
    case json(Data)
    case multipartFormData(MultipartFormData)
    
    var asData: Data? {
        switch self {
        case .data(let data), .json(let data):
            return data
        case .multipartFormData(let multipartFormData):
            return multipartFormData.asData
        }
    }
    
    var contentType: String {
        switch self {
            case .data:
                return "application/octet-stream"
            case .json:
                return "application/json"
            case .multipartFormData(let formData):
                return "multipart/form-data; boundary=\(formData.boundary)"
        }
    }
    
}

