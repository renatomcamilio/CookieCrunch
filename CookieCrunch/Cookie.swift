//
//  Cookie.swift
//  CookieCrunch
//
//  Created by Renato Camilio on 2/20/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import SpriteKit

enum CookieType: Int, Printable {
    
    case Unknown = 0, Croissant, Cupcake, Danish, Donut, Macaroon, SugarCookie
    
    var spriteName: String {
        let spriteNames = [
            "Croissant",
            "Cupcake",
            "Danish",
            "Donut",
            "Macaroon",
            "SugarCookie"]
        
        return spriteNames[rawValue]
    }
    
    var highlightedSpriteName: String {
        return spriteName + "-Highlighted"
    }
    
    static func random() -> CookieType {
        return CookieType(rawValue: Int(arc4random_uniform(UInt32(CookieType.SugarCookie.rawValue))))!
    }
    
    var description: String {
        return spriteName
    }
    
}

// Equatable protocol (implied by Hashable protocol)
// Make sure to put it in the global scope

func ==(lhs: Cookie, rhs: Cookie) -> Bool {
    
    // We're ignoring Cookie's Type here because it's not relevant
    // to detect when they are in the same tile
    
    return lhs.column == rhs.column && lhs.row == rhs.row;
}

class Cookie: Printable, Hashable {
    
    var column: Int
    var row: Int
    let cookieType: CookieType
    var spriteNode: SKSpriteNode?
    
    init(column: Int, row: Int, cookieType: CookieType) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
    }
    
    // Printable protocol
    var description: String {
        return "type: \(cookieType) square:[\(column),\(row)]   "
    }
    
    // Hashable protocol
    var hashValue: Int {
        return (row + column) * 10 // It needs to be unique
    }
    
}