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
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet var popup: Popup!
    
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
    var selectedWordPosition = DBManager.getSavedWord()
    var selectedSubject = DBManager.savedSubject()
    var currentWordAsCharacters: [Character] = []
    var wordAsArray = Array<String>()
    var selectedLetters = ""
    var gameModel: GameModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackButton()
        setupGesture()
    }
    
    private func setupBackButton() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(GameViewController.handleTap(_:)))
        longPressGesture.minimumPressDuration = 0.01
        collectionView.addGestureRecognizer(longPressGesture)
        collectionView.delegate = self
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        clearCells()
        collectionView.reloadData()
    }
    
    @IBAction func handleTap(_ sender: UILongPressGestureRecognizer){
        let state = sender.state
        let location = sender.location(in: self.collectionView)
        switch state {
        case .began:
            break
        case .possible, .changed:
            if let indexPath: NSIndexPath = self.collectionView.indexPathForItem(at: location) as NSIndexPath?{
                if let cell = self.collectionView.cellForItem(at: indexPath as IndexPath) as? LetterCell{
                    self.handleCellSelection(cell: cell)
                }
            }
        case .ended:
            handleTapEnd()
            clearCells()
//            
//            isSameTry = false
            break
        default:
            break
        }
//        self.handleNumOfTries()
    }
    
    @IBAction func moreHintsAction(_ sender: Any) {
    }
    
    func handleCellSelection(cell: LetterCell) {
        if !selectedCells.contains(cell) {
            selectedCells.append(cell)
            cell.setSelected(true)
            selectedLetters += cell.titleLabel.text ?? ""
        } else if selectedCells.count > 1 &&
            cell.tag == selectedCells[selectedCells.endIndex-2].tag {
            let lastCell = selectedCells[selectedCells.endIndex-1]
            lastCell.setSelected(false)
            selectedCells.remove(at: selectedCells.endIndex-1)
            selectedLetters.remove(at:selectedLetters.index(before: selectedLetters.endIndex))
        }
    }

    func handleTapEnd() {
        guard selectedLetters == words[selectedWordPosition] else { return }

        let pop = Popup()
        view.addSubview(pop)
        
        delay(0.5) {
            self.saveData()
        }
        
        delay(0.9) {
            self.clearCells()
            self.collectionView.reloadData()
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
        selectedLetters = ""
    }
    
    func saveData() {
        selectedWordPosition += 1
        
        if selectedWordPosition == words.count {
            // next subject
            if selectedSubject + 1 < gameModel?.words.count ?? 0 {
                selectedSubject += 1
            }
            
            guard let words = gameModel?.words[selectedSubject] else { return }
            
            self.words = words
            selectedWordPosition = 0
            DBManager.saveSubject(type: selectedSubject)
            DBManager.saveWord(word: selectedWordPosition)
        } else if DBManager.savedSubject() == selectedSubject, DBManager.getSavedWord() < selectedWordPosition {
            DBManager.saveWord(word: selectedWordPosition)
//            DBManager.saveScore(score: self.getTotalScore())
        }
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
