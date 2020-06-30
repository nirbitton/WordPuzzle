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
    
    private var selectedCells: [LetterCell] = [] {
        didSet {
            if selectedCells.count == 1 {
                selectedLetterOne.text = selectedCells[0].titleLabel.text
                selectedLetterTwo.text = ""
                selectedLetterThree.text = ""
                selectedLetterFour.text = ""
            } else if selectedCells.count == 2 {
                selectedLetterTwo.text = selectedCells[1].titleLabel.text
                selectedLetterThree.text = ""
                selectedLetterFour.text = ""
            } else if selectedCells.count == 3 {
                selectedLetterThree.text = selectedCells[2].titleLabel.text
                selectedLetterFour.text = ""
            } else if selectedCells.count == 4 {
                selectedLetterFour.text = selectedCells[3].titleLabel.text
            }
        }
    }
    var words: [String] = []
    var selectedWordPosition = 0
    private var currentWordAsCharacters: [Character] = []
    var wordAsArray = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(GameViewController.handleTap(_:)))
        longPressGesture.minimumPressDuration = 0.01
        collectionView.addGestureRecognizer(longPressGesture)
        collectionView.delegate = self
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
            clearCells()
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
            cell.setSelected(true)
        } else if selectedCells.count > 1 &&
            cell.tag == selectedCells[selectedCells.endIndex-2].tag {
            let lastCell = selectedCells[selectedCells.endIndex-1]
            lastCell.setSelected(false)
            selectedCells.remove(at: selectedCells.endIndex-1)
        }
    }
    
    func clearCells(){
        selectedCells.forEach { cell in
            cell.setSelected(false)
        }
        selectedCells.removeAll()
        selectedLetterOne.text = ""
        selectedLetterTwo.text = ""
        selectedLetterThree.text = ""
        selectedLetterFour.text = ""
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        words[selectedWordPosition].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterCell", for: indexPath) as! LetterCell
        if wordAsArray.isEmpty {
            wordAsArray = words[selectedWordPosition].map { String($0) }
        }
        let randomIndex = Int(arc4random_uniform(UInt32(wordAsArray.count)))
        let letter = wordAsArray.remove(at: randomIndex)
        cell.configure(viewModel: LetterCell.ViewModel(title: letter.description, tag: indexPath.row))
        
        return cell
        
    }
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemWidth = (collectionView.bounds.width / CGFloat(2)) - 10
            let itemHeight = collectionView.bounds.height / CGFloat(2)

        return CGSize(width: itemWidth, height: itemHeight)
    }
}
