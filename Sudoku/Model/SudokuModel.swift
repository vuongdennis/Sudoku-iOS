//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Dennis Vuong on 12/10/19.
//  Copyright © 2019 Dennis Vuong. All rights reserved.
//

import Foundation

struct SudokuModel {
//    Repeating is what you want in the array.
//    Count is how many times
    //var sudoku = Array(repeating: Array(repeating: 0, count: 4), count: 4)
    var values: [[String]]
    
    struct SudokuCell {
        var values: String
        var selectable: Bool?
    }
}
