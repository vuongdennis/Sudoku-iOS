//
//  ResultsViewController.swift
//  Sudoku
//
//  Created by Dennis Vuong on 12/19/20.
//  Copyright © 2020 Dennis Vuong. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var results: String?
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.text = results
    }
    
    @IBAction func playAgainPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
