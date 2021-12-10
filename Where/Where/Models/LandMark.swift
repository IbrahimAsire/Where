//
//  LandMark.swift
//  Where
//
//  Created by ibrahim asiri on 24/04/1443 AH.
//

import Foundation
import RealmSwift

class LandMark: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var lat: Double = 0
    @objc dynamic var long: Double = 0
    @objc dynamic var time: Date = Date()
    
}


class CommentUser: Object {
    @objc dynamic var comment: String = ""
}
