//
//  Cafe.swift
//  Where
//
//  Created by ibrahim asiri on 04/05/1443 AH.
//

import Foundation

class Cafe {
    let showImg: String
    let title: String
    let img1: String
    let img2: String
    let nameCafe: String
    let descCafe: String
    var latitude: Double
    var longitude: Double
    
    init(showImg: String, title: String, img1: String, img2: String, nameCafe: String, descCafe: String, latitude: Double, longitude: Double) {
        self.showImg = showImg
        self.title = title
        self.img1 = img1
        self.img2 = img2
        self.nameCafe = nameCafe
        self.descCafe = descCafe
        self.latitude = latitude
        self.longitude = longitude

    }
}


var detlCafe = [
    Cafe(showImg: "dan", title: "Danway Bakery", img1: "dan2", img2: "dan3", nameCafe: "Danway Bakery", descCafe: "King Fahd Rd, Almahalah, Abha 62561", latitude: 18.240026788282425, longitude:  42.5817757),
    Cafe(showImg: "cangro", title: "Kangaroo cafe",img1: "cangro2", img2: "cangro3", nameCafe: "Kangaroo cafe", descCafe: "King Abdulaziz Road, Al Rabwah, Abha 62523", latitude: 18.21726871282791, longitude:  42.52215888465658),
    Cafe(showImg: "Rashfh", title: "Rashfh Coffee",img1: "Rashfh1", img2: "Rashfh2", nameCafe: "Rashfh Coffee", descCafe: "King Fahd Rd, Abha 62527", latitude: 18.236407460131485, longitude:  42.54717948518326),
    Cafe(showImg: "palet2", title: "Palette Cafe", img1: "palette", img2: "palette2", nameCafe: "Palette Cafe", descCafe: "Mahala, Abha 62561 6473", latitude: 18.24043734140768, longitude:  42.581764746030245)
    
    ]

struct CommentCafe {
    let id: String
    var comment: String
}
