
import Foundation

struct NewsPosts: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let url: String
}
