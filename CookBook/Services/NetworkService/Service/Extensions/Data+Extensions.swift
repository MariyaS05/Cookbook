//
//  Data+Extensions.swift

import Foundation

extension Data {
    func parse<T>() throws -> T where T: Decodable {
        try JSONDecoder().decode(T.self, from: self)
    }
}
