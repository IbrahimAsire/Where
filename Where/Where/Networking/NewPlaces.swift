

import UIKit
import FirebaseFirestore

class NewPlacesService {
    static let shared = NewPlacesService()
    let PlacesCollection = Firestore.firestore().collection("newPlaces")
    
    func addPlace(place: NewPlace) {
        PlacesCollection.document(place.placeID!).setData([
            "id": place.placeID,
            "namePlace": place.namePlace,
            "descPlace": place.descPlace,
            
            "userLat": place.userLat!,
            "uesrLong": place.userLong
        ], merge: true)
    }
    
    //MARK: - listen To PlaceInfo
    
    func listenToPlaceInfo(completion: @escaping (([NewPlace]) -> Void)) {
        PlacesCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let docs = snapshot?.documents else { return }
            var places = [NewPlace]()
            
            for doc in docs {
                let data = doc.data()
                guard
                    let placeID = data["placeID"] as? String,
                    let id = data["id"] as? String,
                    let place = data["namePlace"] as? String,
                    let descPlace = data["descPlace"] as? String,
                    let date = data["date"] as? Date,
                    let userLat = data["userLat"] as? Double,
                    let userLong = data["uesrLong"] as? Double
                else {
                    continue
                }
                
                places.append(NewPlace(placeID: placeID, id: id, namePlace: place, descPlace: descPlace, userLat: userLat, userLong: userLong))
            }
            
            completion(places)
        }
    }
    
    //MARK: - Delete Place
    
    func delete(place: NewPlace) {
        
        PlacesCollection.document(place.placeID!).delete()
    }
}

