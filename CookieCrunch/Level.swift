//
//  Level.swift
//  CookieCrunch
//
//  Created by Renato Camilio on 2/21/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

let NumColumns = 9
let NumRows = 9

class Level {
    
    private var cookies = Matrix<Cookie>(columns: NumColumns, rows: NumRows)
    private var tiles = Matrix<Tile>(columns: NumColumns, rows: NumRows)
    
    init(fileName: String) {
        if let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(fileName) {
            if let tilesArray = dictionary["tiles"] as? [[Int]] {
                for (row, rowArray) in enumerate(tilesArray.reverse()) {
                    for (column, value) in enumerate(rowArray) {
                        if value == TileContent.Cookie.rawValue {
                            tiles[column, row] = Tile()
                        }
                    }
                }
            }
        }
    }
    
    func cookieAtColumn(column: Int, row: Int) -> Cookie? {
        assert(column >= 0 && column < cookies.columns, "`column` is out of range in `cookies.columns`")
        assert(row >= 0 && row < cookies.rows, "`row` is out of range in `cookies.rows`")
        
        return cookies[column, row]
    }
    
    func tileAtColumn(column: Int, row: Int) -> Tile? {
        assert(column >= 0 && column < tiles.columns, "`column` is out of range in `tiles.columns`")
        assert(row >= 0 && row < tiles.rows, "`row` is out of range in `tiles.rows`")
        
        return tiles[column, row]
    }
    
    func shuffle() -> Set<Cookie> {
        return createInitialCookies()
    }
    
    private func createInitialCookies() -> Set<Cookie> {
        var set = Set<Cookie>()
        
        for row in 0..<cookies.rows {
            for column in 0..<cookies.columns {
                if tiles[column, row] != nil {
                    var cookieType = CookieType.random()
                    
                    var cookie = Cookie(column: column, row: row, cookieType: cookieType)
                    cookies[column, row] = cookie
                    
                    set.addElement(cookie)
                }
            }
        }
        
        return set
    }
    
}
