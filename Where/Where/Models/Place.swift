//
//  Places.swift
//  Where
//
//  Created by ibrahim asiri on 24/04/1443 AH.
//

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

