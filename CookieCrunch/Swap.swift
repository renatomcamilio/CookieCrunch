//
//  Swap.swift
//  CookieCrunch
//
//  Created by Renato Camilio on 2/22/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

struct Swap: Printable {
    let cookieA: Cookie
    let cookieB: Cookie
    
    init(cookieA: Cookie, cookieB: Cookie) {
        self.cookieA = cookieA
        self.cookieB = cookieB
    }
    
    var description: String {
        return "swap \(cookieA) with \(cookieB)"
    }
}
