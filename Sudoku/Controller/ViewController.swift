//
//  ViewController.swift
//  Sudoku
//
//  Created by Dennis Vuong on 12/9/19.
//  Copyright © 2019 Dennis Vuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SudokuGameManagerDelegate {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    
    var sudokuGameManager = SudokuGameManager()
//    Lazy is when var is null until its accessed.
    lazy var buttonBoard = [
        button1, button2, button3, button4,
        button5, button6, button7, button8,
        button9, button10, button11, button12,
        button13, button14, button15, button16
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sudokuGameManager.delegate = self
        sudokuGameManager.fetchSudoku(level: 1)
    }
    
//MARK: - SudokuGameManagerDelegate functions
    
    func createBoard(_ updateBoard: SudokuGameManager, sudokuBoard: SudokuModel) {
//        DispatchQueue tells it to go onto the next step as it updates in the background
        DispatchQueue.main.async {
            var flatten = sudokuBoard.values.flatMap { $0 }
            
            for i in 0...15 {
                self.buttonBoard[i]!.setTitle(flatten[i], for: .normal)
                
//                if flatten[i].values == "" {
//                    flatten[i].selectable = true
//                } else {
//                    flatten[i].selectable = false
//                }

            }
//            self.button1.setTitle(sudokuBoard.values[0][0], for: .normal)
//            self.button2.setTitle(sudokuBoard.values[0][1], for: .normal)
//            self.button3.setTitle(sudokuBoard.values[0][2], for: .normal)
//            self.button4.setTitle(sudokuBoard.values[0][3], for: .normal)
//            self.button5.setTitle(sudokuBoard.values[1][0], for: .normal)
//            self.button6.setTitle(sudokuBoard.values[1][1], for: .normal)
//            self.button7.setTitle(sudokuBoard.values[1][2], for: .normal)
//            self.button8.setTitle(sudokuBoard.values[1][3], for: .normal)
//            self.button9.setTitle(sudokuBoard.values[2][0], for: .normal)
//            self.button10.setTitle(sudokuBoard.values[2][1], for: .normal)
//            self.button11.setTitle(sudokuBoard.values[2][2], for: .normal)
//            self.button12.setTitle(sudokuBoard.values[2][3], for: .normal)
//            self.button13.setTitle(sudokuBoard.values[3][0], for: .normal)
//            self.button14.setTitle(sudokuBoard.values[3][1], for: .normal)
//            self.button15.setTitle(sudokuBoard.values[3][2], for: .normal)
//            self.button16.setTitle(sudokuBoard.values[3][3], for: .normal)
        }
    }
    
    func failedWithError(error: Error) {
        print("error")
    }
}

