//
//  Cafes.swift
//  Where
//
//  Created by ibrahim asiri on 20/04/1443 AH.
//

import Foundation

class Cafe {
    let showImg: String
    let title: String
    let img1: String
    let img2: String
    let nameCafe: String
    let descCafe: String
    
    init(showImg: String, title: String, img1: String, img2: String, nameCafe: String, descCafe: String) {
        self.showImg = showImg
        self.title = title
        self.img1 = img1
        self.img2 = img2
        self.nameCafe = nameCafe
        self.descCafe = descCafe

    }
}

var detlCafe = [
    Cafe(showImg: "dan", title: "Danway Bakery", img1: "dan2", img2: "dan3", nameCafe: "Danway Bakery", descCafe: "King Fahd Rd, Almahalah, Abha 62561"),
    Cafe(showImg: "cangro", title: "Kangaroo cafe",img1: "cangro2", img2: "cangro3", nameCafe: "Kangaroo cafe", descCafe: "King Abdulaziz Road, Al Rabwah, Abha 62523"),
    Cafe(showImg: "Rashfh", title: "Rashfh Coffee",img1: "Rashfh1", img2: "Rashfh2", nameCafe: "Rashfh Coffee", descCafe: "King Fahd Rd, Abha 62527"),
    Cafe(showImg: "palet2", title: "Palette Cafe", img1: "palette", img2: "palette2", nameCafe: "Palette Cafe", descCafe: "Mahala, Abha 62561 6473")
    ]


struct CommentCafe {
    let id: String
    var comment: String
}
