//
//  ApiEndpointProtocol.swift

//
import Foundation

protocol APIEndpointProtocol {
    var method: HTTPMethod { get }
    var path: String { get }
    var baseURL: String { get }
    var headers: [String: String] { get }
    var urlParams: [String: any CustomStringConvertible] { get }
    var urlRequest: URLRequest? { get }
    var body: HTTPBody? { get }
}

extension APIEndpointProtocol {
    var urlRequest: URLRequest? {
        var components = URLComponents(string: baseURL + path)
        
        if !urlParams.isEmpty {
            components?.queryItems = urlParams.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
        }
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body?.asData
        
        return request
    }
}
