//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Denis Zubkov on 18/10/2018.
//  Copyright © 2018 Denis Zubkov. All rights reserved.
//

import Foundation

struct Registration {
    var name: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdult: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}

struct RoomType {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
}

extension RoomType: Equatable {
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}


