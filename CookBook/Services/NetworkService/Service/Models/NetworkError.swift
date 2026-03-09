//
//  NetworkError.swift
//  NetworkLayer
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case informational
    case redirection
    case clientError
    case serverError
    case noInternetConnection
    case timeout
    case invalidResponse
    case decodingError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .informational:        return "Informational response received."
        case .redirection:          return "Request was redirected."
        case .clientError:          return "Client error. Check the request."
        case .serverError:          return "Server error. Try again later."
        case .noInternetConnection: return "No internet connection."
        case .timeout:              return "Request timed out."
        case .invalidResponse:      return "Invalid server response."
        case .decodingError:        return "Failed to parse server response."
        case .unknown:              return "An unknown error occurred."
        }
    }
}

enum NetworkHTTPResponseService {
    case informational
    case success
    case redirection
    case clientError
    case serverError
    case unknown
    
    init(urlResponse: HTTPURLResponse) {
        switch urlResponse.statusCode {
        case 100..<200: self = .informational
        case 200..<300: self = .success
        case 300..<400: self = .redirection
        case 400..<500: self = .clientError
        case 500..<600: self = .serverError
        default:        self = .unknown
        }
    }
}
