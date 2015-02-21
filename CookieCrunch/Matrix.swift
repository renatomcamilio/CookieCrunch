//
//  Matrix.swift
//  CookieCrunch
//
//  Created by Renato Camilio on 2/20/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

struct Matrix<T> {
    let columns: Int
    let rows: Int
    private var array: [T?]
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = [T?](count: rows * columns, repeatedValue: nil)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row * columns + column]
        }
        set {
            array[row * columns + column] = newValue
        }
    }
}
