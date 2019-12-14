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
    
//MARK: - USER Input Functionality

//    Will unselect the cell if you press the background
    @IBAction func backgroundButton(_ sender: UIButton) {
        if selectedCell != nil {
            selectedCell?.backgroundColor = .white
        }
    }
    
//    If the user presses a cell on the board
    @IBAction func sudokuButtonBoardPressed(_ sender: UIButton) {
//        If selectedCell isn't empty. Make the old selected Cell white
        if selectedCell != nil {
            selectedCell?.backgroundColor = .white
        }
//        If selectedCell is the same as the sender. Meaning the same button pressed.
//        Make it white
        if selectedCell == sender {
            selectedCell?.backgroundColor = .white
//            If it's different. Orange.
        } else {
            selectedCell = sender
            selectedCell?.backgroundColor = .systemOrange
        }
    }

//  If the user presses an input button
    @IBAction func userInteractionButtonPressed(_ sender: UIButton) {
        if selectedCell != nil {
            selectedCell?.setTitle(sender.currentTitle, for: .normal)
        }
    }
    
//MARK: - SudokuGameManagerDelegate functions
    
    func createBoard(sudokuBoardValues: [SudokuModel]) {
        //        DispatchQueue tells it to go onto the next step as it updates in the background
        DispatchQueue.main.async {
            for i in 0...15 {
                self.sudokuButtonBoard[i].setTitle(sudokuBoardValues[i].values, for: .normal)
                
                //                Sees if the cell is selectable.
                //                If so then allow users to be able to click on it.
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
    
    func gameLogic(sudokuBoard: [SudokuModel]) {
    }
    
    func failedWithError(error: Error) {
        print("error")
    }
}

