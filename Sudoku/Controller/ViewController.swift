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
    
    @IBAction func buttonCellPressed(_ sender: UIButton) {
        var update = 0
        update += 1
        print(update)
    }
    
    //MARK: - SudokuGameManagerDelegate functions
    
    func createBoard(_ updateBoard: SudokuGameManager, sudokuBoard: [SudokuModel]) {
//        DispatchQueue tells it to go onto the next step as it updates in the background
        DispatchQueue.main.async {
            for i in 0...15 {
                self.buttonBoard[i]!.setTitle(sudokuBoard[i].values, for: .normal)
                
                if sudokuBoard[i].selectable! {
                    self.buttonBoard[i]!.isEnabled = true
                } else {
                    self.buttonBoard[i]!.isEnabled = false
                }
            }
        }
    }
    
    func failedWithError(error: Error) {
        print("error")
    }
}

