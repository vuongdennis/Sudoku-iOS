//
//  SudokuManager.swift
//  Sudoku
//
//  Created by Dennis Vuong on 12/10/19.
//  Copyright © 2019 Dennis Vuong. All rights reserved.
//

import Foundation

protocol SudokuGameManagerDelegate {
    func createBoard(_ updateBoard: SudokuGameManager, sudokuBoard: SudokuModel)
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
                        self.delegate?.createBoard(self, sudokuBoard: sudokuBoard)
                    }
//                    This print() prints out the parsedData in a readable textformat
                    //print("JSON String: \(String(data: passedData, encoding: .utf8))")
                }
            }
//          4.  New tasks are suspended which means we need to "restart" it
            task.resume()
        }
    }
    
    func parseJSON(sudokuData: Data) -> SudokuModel? {
//        Creating decoder
        let decoder = JSONDecoder()
        do {
//            Attempts to decode the data
            let decodedData = try decoder.decode(SudokuData.self, from: sudokuData)
            
//            Creates an a 2D array of size 4x4 with 0's
            var sudoku = Array(repeating: Array(repeating: "", count: 4), count: 4)
            
//            Will go thru each item/object of the decodedData
//            Use the object's x and y to set it's data
            for values in decodedData.squares {
                sudoku[values.x][values.y] = String(values.value)
            }
            
//            Returns the whole 2D array which is the board
            return SudokuModel(values: sudoku)
        } catch {
            delegate?.failedWithError(error: error)
            return nil
        }
    }
}
