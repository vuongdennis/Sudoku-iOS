//
//  ViewController.swift
//  Sudoku
//
//  Created by Dennis Vuong on 12/9/19.
//  Copyright © 2019 Dennis Vuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SudokuGameManagerDelegate {

    @IBOutlet var sudokuButtonBoard: [UIButton]!
    @IBOutlet var userInteractionButtons: [UIButton]!
    
    var sudokuGameManager = SudokuGameManager()
    var selectedCell: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sudokuGameManager.delegate = self
        sudokuGameManager.fetchSudoku(level: 1)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        var updatedBoard = [[Int]]()
        for _ in 0...3 {
            updatedBoard.append([0, 0, 0, 0])
        }
        
        var counter = 0
        for i in 0...3 {
            for j in 0...3 {
                updatedBoard[i][j] = Int(sudokuButtonBoard[counter].currentTitle!) ?? 0
                counter += 1
            }
        }
        
        if sudokuGameManager.gameLogic(board: updatedBoard) == true {
            print("Success")
        } else {
            print("fail")
        }
    }
    
//MARK: - USER Input Functionality

//    Will unselect the cell if you press the background
    @IBAction func backgroundButton(_ sender: UIButton) {
//        If there is a selectedCell, unselect it,
//        and make it white
        if selectedCell != nil {
            selectedCell?.backgroundColor = .white
            selectedCell = nil
        }
    }
    
//    If the user presses a cell on the board
    @IBAction func sudokuButtonBoardPressed(_ sender: UIButton) {
//        If senderCell is white make it orange'
//        if orange make it white
//        if it was white -> orange make it the selectedCell
        if sender.backgroundColor!.isEqual(UIColor.white) {
            sender.backgroundColor = .systemOrange
            selectedCell = sender
        } else {
            sender.backgroundColor = .white
        }
    }

//  If the user presses an input button
    @IBAction func userInteractionButtonPressed(_ sender: UIButton) {
        if selectedCell != nil {
            selectedCell?.setTitle(sender.currentTitle, for: .normal)
//            We can have it so that when a user inputs data onto the board.
//            It will deselect and make the selected tile white.
//            selectedCell?.backgroundColor = .white
//            selectedCell = nil
        }
    }
    
//MARK: - SudokuGameManagerDelegate functions
    
    func createBoard(sudokuBoardValues: [SudokuCellModel]) {
        //        DispatchQueue tells it to go onto the next step as it updates in the background
        DispatchQueue.main.async {
            for i in 0...15 {
                self.sudokuButtonBoard[i].setTitle(sudokuBoardValues[i].values, for: .normal)
                
                //Sees if the cell is selectable.
                //If so then allow users to be able to click on it.
                if sudokuBoardValues[i].selectable! {
                    self.sudokuButtonBoard[i].isEnabled = true
                } else {
                    self.sudokuButtonBoard[i].isEnabled = false
                }
                
                //Sets the cells without values to a different color than the partially filled
                if sudokuBoardValues[i].values == "" {
                    self.sudokuButtonBoard[i].setTitleColor(.systemPink, for: .normal)
                }
            }
        }
    }
    
    func gameLogic(sudokuBoard: [SudokuCellModel]) {
    }
    
    func failedWithError(error: Error) {
        print("error")
    }
}

