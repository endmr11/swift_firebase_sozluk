//
//  Kelimeler.swift
//  udemy_firebase_sozluk
//
//  Created by Eren Demir on 14.05.2022.
//

import Foundation


class Kelimeler {
    var kelime_id:String?
    var turkce:String?
    var ingilizce:String?
    
    init() {
        
    }
    init(kelime_id:String,turkce:String,ingilizce:String) {
        self.kelime_id = kelime_id
        self.turkce = turkce
        self.ingilizce = ingilizce
    }
}


//class Kelimeler:Codable {
//    var kelimeler: [Kelime]?
//}
//
//class Kelime:Codable {
//    var kelime_id:String?
//    var turkce:String?
//    var ingilizce:String?
//
//    init() {
//
//    }
//    init(kelime_id:String,turkce:String,ingilizce:String) {
//        self.kelime_id = kelime_id
//        self.turkce = turkce
//        self.ingilizce = ingilizce
//    }
//}
