//
//  GameViewController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 28/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, Storyboarded {

    // MARK: - Outlets

    @IBOutlet weak var selectedLetterOne: UILabel!
    @IBOutlet weak var selectedLetterTwo: UILabel!
    @IBOutlet weak var selectedLetterThree: UILabel!
    @IBOutlet weak var selectedLetterFour: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    
    private var selectedCells: [LetterCell] = []
    var words: [String] = []
    var selectedWordPosition = 0
    private var currentWordAsCharacters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(GameViewController.handleTap(_:)))
        longPressGesture.minimumPressDuration = 0.01
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer){
        let state = sender.state
        let location = sender.location(in: self.collectionView)
        switch state {
        case .began:
            break
        case .changed:
            if let indexPath: NSIndexPath = self.collectionView.indexPathForItem(at: location) as NSIndexPath?{
                if let cell = self.collectionView.cellForItem(at: indexPath as IndexPath) as? LetterCell{
                    self.handleCellSelection(cell: cell)
                }
            }
        case .ended:
//            success()
//            clearCells()
//            
//            isSameTry = false
            break
        default:
            break
        }
//        self.handleNumOfTries()
    }
    
    func handleCellSelection(cell: LetterCell) {
        if !selectedCells.contains(cell) {
            selectedCells.append(cell)
            //            cell.backgroundColor = UIColor.midPurple()
            //            cell.letter.textColor = UIColor.nOrangeColor()
        } else if selectedCells.count > 1 &&
            cell.tag == selectedCells[selectedCells.endIndex-2].tag {
            //                lastCell.backgroundColor = UIColor.lightPurple()
            //                lastCell.letter.textColor = UIColor.darkPurple()
            
            selectedCells.remove(at: selectedCells.endIndex-1)
        }
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        words[selectedWordPosition].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterCell", for: indexPath) as! LetterCell
        let randomIndex = Int(arc4random_uniform(UInt32(currentWordAsCharacters.count)))
        
        let selectedWord = words[selectedWordPosition]
        var wordAsArray = Array(selectedWord)
        let letter = wordAsArray.remove(at: randomIndex)
        cell.configure(viewModel: LetterCell.ViewModel(title: letter.description, isSelected: false, tag: indexPath.row))
        
        return cell
        
    }
}
