import Foundation

struct Converter: Decodable {
    let status: Int
    let message: String
    let data: [String: String]
}
