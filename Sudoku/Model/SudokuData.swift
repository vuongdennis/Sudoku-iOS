//
//  SudokuData.swift
//  Sudoku
//
//  Created by Dennis Vuong on 12/10/19.
//  Copyright © 2019 Dennis Vuong. All rights reserved.
//

import Foundation

struct SudokuData: Decodable {
    let squares: [Squares]
}

struct Squares: Decodable {
    let x: Int
    let y: Int
    let value: Int
}
