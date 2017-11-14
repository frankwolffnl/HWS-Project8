//
//  ViewController.swift
//  Project8
//
//  Created by Frank Wolff on 06/11/2017.
//  Copyright © 2017 Frank Wolff. All rights reserved.
//  Last page visited: https://www.hackingwithswift.com/read/8/3/loading-a-level-addtarget-and-shuffling-arrays

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1
    
    override func viewDidLoad() {
		super.viewDidLoad()
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
		loadLevel()
	}
    
    func loadLevel() {
        var clueString = ""
		var solutionString = ""
		var letterBits = [String]()
		
		if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
			if let levelContents = try? String(contentsOfFile: levelFilePath) {
				var lines = levelContents.components(separatedBy: "\n")
				lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
				
				for (index, line) in lines.enumerated() {
					let parts = line.components(separatedBy: ": ")
					let answer = parts[0]
					// De fix
					if answer == "" { break }
					let clue = parts[1]
					
					clueString += "\(index + 1). \(clue)\n"
					
					let solutionWord = answer.replacingOccurrences(of: "|", with: "")
					solutionString += "\(solutionWord.count) letters\n"
					solutions.append(solutionWord)
					
					let bits = answer.components(separatedBy: "|")
					letterBits += bits
				}
			}
		}
		cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
		answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
		
		letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
		
		if letterBits.count == letterButtons.count {
			for i in 0 ..< letterBits.count {
				letterButtons[i].setTitle(letterBits[i], for: .normal)
			}
		}
    }

    @IBAction func submitTapped(_ sender: UIButton) {
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
    }
    
    @objc func letterTapped(btn: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}


}

