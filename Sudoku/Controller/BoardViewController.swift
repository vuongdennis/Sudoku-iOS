//
//  ViewController.swift
//  Sudoku
//
//  Created by Dennis Vuong on 12/9/19.
//  Copyright © 2019 Dennis Vuong. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, SudokuGameManagerDelegate {

    @IBOutlet var sudokuButtonBoard: [UIButton]!
    @IBOutlet var userInteractionButtons: [UIButton]!
    
    var sudokuGameManager = SudokuGameManager()
    var reset = ResultsViewController()
    var selectedCell: UIButton?
    var win = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sudokuGameManager.delegate = self
        sudokuGameManager.fetchSudoku(level: 2)
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
            win = true
        } else {
            win = false
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            if win {
                destinationVC.results = "Success"
            } else {
                destinationVC.results = "Try Again"
            }
        }
    }
    
    @IBAction func newBoardPressed(_ sender: UIButton) {
        sudokuGameManager.fetchSudoku(level: 2)
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
//        If there is a selectedCell and sender is not equal to the same cell,
//        Make the OLD selectedCell white
        if selectedCell != nil {
            if selectedCell != sender {
                selectedCell?.backgroundColor = .white
            }
        }
//        If White -> Orange then selected
//        If Orange -> White then notSelected
        if sender.backgroundColor!.isEqual(UIColor.white) {
            sender.backgroundColor = .systemOrange
            selectedCell = sender
        } else {
            sender.backgroundColor = .white
            selectedCell = nil
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
        //DispatchQueue tells it to go onto the next step as it updates in the background
        DispatchQueue.main.async {
            for i in 0...15 {
                self.sudokuButtonBoard[i].setTitle(sudokuBoardValues[i].values, for: .normal)
                self.sudokuButtonBoard[i].setTitleColor(.black, for: .normal)
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
    
    func failedWithError(error: Error) {
        print("error")
    }
}

