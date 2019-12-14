//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Dennis Vuong on 12/10/19.
//  Copyright © 2019 Dennis Vuong. All rights reserved.
//

import Foundation

struct SudokuCellModel {
//    Value of the Cell.
    var values: String
//    If the cell is selectable
    var selectable: Bool?
//    If the cell is SELECTED
    var selected = false
}
