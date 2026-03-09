//
//  MultipartFormData.swift
//  NetworkLayer
//
import Foundation

struct MultipartFormData {
    let boundary: String

    let fileData: Data

    let fileName: String
    
    let mimeType: MimeType

    let parameters: [String: String]

    init(
        boundary: String,
        fileData: Data,
        fileName: String,
        mimeType: MimeType,
        parameters: [String : String]
    ) {
        self.boundary = boundary
        self.fileData = fileData
        self.fileName = fileName
        self.mimeType = mimeType
        self.parameters = parameters
    }

    var asData: Data {
        var body = Data()
        let lineBreak = "\r\n".data(using: .utf8)!

        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType.rawValue)\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append(lineBreak)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
}

extension MultipartFormData {

    var asHttpBodyData: Data {
        var body = Data()
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType.rawValue)\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        return body
    }
}
