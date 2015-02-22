//
//  Level.swift
//  CookieCrunch
//
//  Created by Renato Camilio on 2/21/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//


class Level {
    
    private var cookies = Matrix<Cookie>(columns: 9, rows: 9)
    
    func cookieAtColumn(column: Int, row: Int) -> Cookie? {
        assert(column >= 0 && column < cookies.columns, "`column` is out of range in `cookies.columns`")
        assert(row >= 0 && row < cookies.rows, "`row` is out of range in `cookies.rows`")
        
        return cookies[column, row]
    }
    
    private func createInitialCookies() -> Set<Cookie> {
        var set = Set<Cookie>()
        
        for row in 0..<cookies.rows {
            for column in 0..<cookies.columns {
                let cookieType = CookieType.random()
                
                var cookie = Cookie(column: column, row: row, cookieType: cookieType)
                cookies[column, row] = cookie
                
                set.addElement(cookie)
            }
        }
        
        return set
    }

    func shuffle() -> Set<Cookie> {
        return createInitialCookies()
    }
    
}
