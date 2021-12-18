
import Foundation

class Cafe {
    let showImg: String
    let img1: String
    let img2: String
    let nameCafe: String
    let descCafe: String
    var latitude: Double
    var longitude: Double
    var commint: String
    
    init(showImg: String, img1: String, img2: String, nameCafe: String, descCafe: String, latitude: Double, longitude: Double, commint: String) {
        self.showImg = showImg
        self.img1 = img1
        self.img2 = img2
        self.nameCafe = nameCafe
        self.descCafe = descCafe
        self.latitude = latitude
        self.longitude = longitude
        self.commint = commint

    }
}

var detlCafe = [
    Cafe(showImg: "dan", img1: "dan2", img2: "dan3", nameCafe: "Danway Bakery".Localizable(), descCafe: "King Fahd Rd, Almahalah, Abha 62561".Localizable(), latitude: 18.24018982421746, longitude: 42.58194736137367, commint: ""),
    
    Cafe(showImg: "cangro", img1: "cangro2", img2: "cangro3", nameCafe: "Kangaroo cafe", descCafe: "King Abdulaziz Road, Al Rabwah, Abha 62523".Localizable(), latitude: 18.24018982421746, longitude: 42.58194736137367, commint: ""),
    
    Cafe(showImg: "Rashfh", img1: "Rashfh1", img2: "Rashfh2", nameCafe: "Rashfh Coffee", descCafe: "King Fahd Rd, Abha 62527".Localizable(), latitude: 18.24018982421746, longitude: 42.58194736137367, commint: ""),
    
    Cafe(showImg: "palet2", img1: "palette", img2: "palette2", nameCafe: "Palette Cafe", descCafe: "Mahala, Abha 62561 6473".Localizable(), latitude: 18.24018982421746, longitude: 42.58194736137367, commint: ""),
    
    Cafe(showImg: "leon", img1: "leon1", img2: "leon2", nameCafe: "LEON Cafe".Localizable(), descCafe: "King Fahd Road, Al Manhal, Abha 62521".Localizable(), latitude: 18.223544089257654, longitude: 42.51763892412773, commint: "")
    
    ]


struct CommentCafe {
    let id: String
    var comment: String
}
