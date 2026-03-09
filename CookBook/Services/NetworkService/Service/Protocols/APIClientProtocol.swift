//
//  APIClientProtocol.swift

import Foundation

protocol APIClientProtocol {
    func sendRequest<T: Decodable>(_ endpoint: any APIEndpointProtocol) async -> Result<T, NetworkError>
}

extension APIClientProtocol {
    var urlSession: URLSession { .shared }
    
    func sendRequest<T: Decodable>(_ endpoint: any APIEndpointProtocol) async  -> Result<T, NetworkError> {
        guard let request = endpoint.urlRequest else { return .failure(.informational)}
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await urlSession.data(for: request)
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet,
                    .networkConnectionLost:
                return .failure(.noInternetConnection)
            case .timedOut:
                return .failure(.timeout)
            default:
                return .failure(.unknown)
            }
        } catch {
            return .failure(.unknown)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(.invalidResponse)
        }
    
        
        switch NetworkHTTPResponseService(urlResponse: httpResponse) {
        case .success:
            do {
                let decoded: T = try data.parse()
                return .success(decoded)
            } catch {
                return .failure(.decodingError)
            }
        case .informational: return .failure(.informational)
        case .redirection:   return .failure(.redirection)
        case .clientError:   return .failure(.clientError)
        case .serverError:   return .failure(.serverError)
        case .unknown:       return .failure(.unknown)
        }
    }
}
