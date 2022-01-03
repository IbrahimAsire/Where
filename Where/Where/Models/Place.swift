
import Foundation
import RealmSwift

class Place {
    static let shared = Place()
    var landMarks: Results<LandMark>!
    var userLat: Double = 0
    var userLong: Double = 0
    private init() {}
    
}

class Comment {
    static let shared = Comment()
    var comments: Results<CommentUser>!
    
    }

struct NewPlace {
    let id: String
    var namePlace: String
    var descPlace: String
    var time: Date = Date()
    var userLat: Double
    var userLong: Double
    
}

