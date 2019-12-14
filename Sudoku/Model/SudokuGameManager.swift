//
//  SudokuManager.swift
//  Sudoku
//
//  Created by Dennis Vuong on 12/10/19.
//  Copyright © 2019 Dennis Vuong. All rights reserved.
//

import Foundation

protocol SudokuGameManagerDelegate {
    func createBoard(sudokuBoardValues: [SudokuCellModel])
    func gameLogic(sudokuBoard: [SudokuCellModel])
    func failedWithError(error: Error)
}

struct SudokuGameManager {
    let sudokuAPI = K.apiName
    
    var delegate: SudokuGameManagerDelegate?
    
//    Function to start retrieving the board
    func fetchSudoku(level: Int) {
        let urlString = "\(sudokuAPI)&level=\(level)"
        performRequest(with: urlString)
    }
    
//    Takes in the url string and tries to find a connection
    func performRequest(with urlString: String) {
//        1. Creates a URL object from URL struct
        if let url = URL(string: urlString) {
//            2. Able to create a session to download data
            let session = URLSession(configuration: .default)
//            3. Part of the URLSession class.
//            Creates a task that retrieves the contents of the URL. Then calls the completetion
//            handler
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.failedWithError(error: error!)
                    return
                }
                
                if let passedData = data {
                    if let sudokuBoard = self.parseJSON(sudokuData: passedData) {
                        self.delegate?.createBoard(sudokuBoardValues: sudokuBoard)
                    }
//                    This print() prints out the parsedData in a readable textformat
                    //print("JSON String: \(String(data: passedData, encoding: .utf8))")
                }
            }
//          4.  New tasks are suspended which means we need to "restart" it
            task.resume()
        }
    }
    
    func parseJSON(sudokuData: Data) -> [SudokuCellModel]? {
//        Creating decoder
        let decoder = JSONDecoder()
        do {
//            Attempts to decode the data
            let decodedData = try decoder.decode(SudokuData.self, from: sudokuData)
            
//            Initializing the Board which will be a 2D Array
            var sudoku = [[SudokuCellModel]]()
            
//            Sets the Board to 4x4 starting cells
            for _ in 0...3 {
                sudoku.append([
                    SudokuCellModel(values: ""),
                    SudokuCellModel(values: ""),
                    SudokuCellModel(values: ""),
                    SudokuCellModel(values: "")
                ])
            }

//            Will go thru each item/object of the decodedData
//            Use the object's x and y to set it's data
            for values in decodedData.squares {
                sudoku[values.x][values.y].values = String(values.value)
            }
            
            var flattenedSudokuBoard = sudoku.flatMap { $0 }
            
//            Goes thru the board. If it's selectable then mark true else false
            for i in 0...15 {
                if flattenedSudokuBoard[i].values == "" {
                    flattenedSudokuBoard[i].selectable = true
                } else {
                    flattenedSudokuBoard[i].selectable = false
                }
            }
//            Returns the flattenedSudokuBoard
            return flattenedSudokuBoard
        } catch {
            delegate?.failedWithError(error: error)
            return nil
        }
    }
    
//MARK: - Game Logic
    func gameLogic(board: [[Int]]) -> Bool{
//        Checks to see duplicates in each row and column
        for i in 0...3 {
            let rowValue = checkRow(board: board, row: i)
            let colValue = checkCol(board: board, col: i)
            
            if rowValue != true || colValue != true {
                return false
            }
        }
        return true
    }
    
    func checkRow(board: [[Int]], row: Int) -> Bool {
        var setValues: Set = [1, 2, 3, 4]
        for i in 0...3 {
            if setValues.contains(board[row][i]) {
                setValues.remove(board[row][i])
            } else {
                return false
            }
        }
        return true
    }
    
    func checkCol(board: [[Int]], col: Int) -> Bool {
        var setValues: Set = [1, 2, 3, 4]
        for i in 0...3 {
            if setValues.contains(board[i][col]) {
                setValues.remove(board[i][col])
            } else {
                return false
            }
        }
        return true
    }
}
