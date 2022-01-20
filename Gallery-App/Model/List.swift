//
//  List.swift
//  Gallery-App
//
//  Created by Phincon on 20/01/22.
//

import Foundation

struct List : Decodable {
    var albumId : Int
    var id : Int
    var title : String
    var url : String
    var thumbnailUrl : String
}
