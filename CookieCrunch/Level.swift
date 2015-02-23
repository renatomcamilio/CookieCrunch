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
    private var possibleSwaps = Set<Swap>()
    
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
        var set: Set<Cookie>
        do {
            set = createInitialCookies()
            detectPossibleSwaps()
            println("possible swaps: \(possibleSwaps)")
        }
            while possibleSwaps.count == 0
        
        return set
    }
    
    func detectPossibleSwaps() {
        possibleSwaps = Set<Swap>()
        
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let cookie = cookies[column, row] {
                    
                    if column < NumColumns - 1 {
                        if let other = cookies[column + 1, row] {
                            // Swap them
                            cookies[column, row] = other
                            cookies[column + 1, row] = cookie
                            
                            // Is either cookie now part of a chain?
                            if hasChainAtColumn(column + 1, row: row) ||
                                hasChainAtColumn(column, row: row) {
                                    possibleSwaps.addElement(Swap(cookieA: cookie, cookieB: other))
                            }
                            
                            // Swap them back
                            cookies[column, row] = cookie
                            cookies[column + 1, row] = other
                        }
                    }
                    
                    if row < NumRows - 1 {
                        if let other = cookies[column, row + 1] {
                            cookies[column, row] = other
                            cookies[column, row + 1] = cookie
                            
                            // Is either cookie now part of a chain?
                            if hasChainAtColumn(column, row: row + 1) ||
                                hasChainAtColumn(column, row: row) {
                                    possibleSwaps.addElement(Swap(cookieA: cookie, cookieB: other))
                            }
                            
                            // Swap them back
                            cookies[column, row] = cookie
                            cookies[column, row + 1] = other
                        }
                    }
                }
            }
        }
    }
    
    private func hasChainAtColumn(column: Int, row: Int) -> Bool {
        let cookieType = cookies[column, row]!.cookieType
        
        var horzLength = 1
        for var i = column - 1; i >= 0 && cookies[i, row]?.cookieType == cookieType;
            --i, ++horzLength { }
        for var i = column + 1; i < NumColumns && cookies[i, row]?.cookieType == cookieType;
            ++i, ++horzLength { }
        if horzLength >= 3 { return true }
        
        var vertLength = 1
        for var i = row - 1; i >= 0 && cookies[column, i]?.cookieType == cookieType;
            --i, ++vertLength { }
        for var i = row + 1; i < NumRows && cookies[column, i]?.cookieType == cookieType;
            ++i, ++vertLength { }
        return vertLength >= 3
    }
    
    private func createInitialCookies() -> Set<Cookie> {
        var cookiesSet = Set<Cookie>()
        
        for row in 0..<cookies.rows {
            for column in 0..<cookies.columns {
                if tiles[column, row] != nil {
                    var cookieType: CookieType
                    do {
                        cookieType = CookieType.random()
                    } while (column >= 2 &&
                            cookies[column - 1, row]?.cookieType == cookieType &&
                            cookies[column - 2, row]?.cookieType == cookieType)
                            || (row >= 2 &&
                                cookies[column, row - 1]?.cookieType == cookieType &&
                                cookies[column, row - 2]?.cookieType == cookieType)
                    
                    var cookie = Cookie(column: column, row: row, cookieType: cookieType)
                    cookies[column, row] = cookie
                    
                    cookiesSet.addElement(cookie)
                }
            }
        }
        
        return cookiesSet
    }
    
    func performSwap(swap: Swap) {
        let columnA = swap.cookieA.column
        let rowA = swap.cookieA.row
        let columnB = swap.cookieB.column
        let rowB = swap.cookieB.row
        
        cookies[columnA, rowA] = swap.cookieB
        swap.cookieB.column = columnA
        swap.cookieB.row = rowA
        
        cookies[columnB, rowB] = swap.cookieA
        swap.cookieA.column = columnB
        swap.cookieA.row = rowB
    }
    
    func isPossibleSwap(swap: Swap) -> Bool {
        return possibleSwaps.containsElement(swap)
    }
    
}
