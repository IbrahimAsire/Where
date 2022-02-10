
import Foundation

struct NewPlace {
    let placeID: String?
    let id: String?
    var namePlace: String?
    var descPlace: String?
    var time: Date = Date()
    var userLat: Double?
    var userLong: Double?
    
    func getData() -> [String: Any] {
        return ["placeID":self.placeID, "id": id, "namePlace":self.namePlace,"descPlace":self.descPlace, "time": time, "userLat":self.userLat, "userLong":self.userLong]
    }
    
}

