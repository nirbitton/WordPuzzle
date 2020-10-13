//
//  GameViewController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 28/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameViewController: UIViewController, Storyboarded {

    // MARK: - Outlets

    @IBOutlet weak var selectedLetterOne: UILabel!
    @IBOutlet weak var selectedLetterTwo: UILabel!
    @IBOutlet weak var selectedLetterThree: UILabel!
    @IBOutlet weak var selectedLetterFour: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var popup: Popup!
    @IBOutlet weak var hintBtn: UIButton!
    
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
    var selectedSubject = 0
    var currentWordAsCharacters: [Character] = []
    var wordAsArray = Array<String>()
    var selectedLetters = ""
    var gameModel: GameModel!
    var numberOfTries = 0
    var isSameTry = false
    
    var rewardedAd: GADRewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackButton()
        setupGesture()
        setupHintButton()
        setupTitile()
        setupAdMob()
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
    
    private func setupHintButton() {
        let numberOfHint = DBManager.getSavedHint()
        hintLabel.text = "רמז" + "(" + String(numberOfHint) + ")!"
        hintBtn.isEnabled = numberOfHint > 0
    }
    
    private func setupTitile() {
        titleLabel.text = gameModel?.subject.name
    }
    
    private func setupAdMob() {
        rewardedAd = createAndLoadRewardedAd()
    }
    
    private func createAndLoadRewardedAd() -> GADRewardedAd? {
      rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
      rewardedAd?.load(GADRequest()) { error in
        if let error = error {
          print("Loading failed: \(error)")
        } else {
          print("Loading Succeeded")
        }
      }
      return rewardedAd
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        collectionView.reloadData()
    }
    
    @IBAction func hintAction(_ sender: Any) {
        guard DBManager.getSavedHint() > 0 else { return }
        
        DBManager.addHint(hint: -1)
        setupHintButton()
        
        var arr: [Character] = []
        let currentWord = words[selectedWordPosition] as String
        if wordAsArray.count == 0 {
            arr = Array(currentWord)
        }
        
        if selectedLetterOne.text == nil || selectedLetterOne.text == "" {
            let caf = arr[0]
            selectedLetterOne.text = caf.description
        }
        else if selectedLetterTwo.text == nil || selectedLetterTwo.text == "" {
            let caf = arr[1]
            selectedLetterTwo.text = caf.description
        }
        else if selectedLetterThree.text == nil || selectedLetterThree.text == "" {
            let caf = arr[2]
            selectedLetterThree.text = caf.description
        }
        else if selectedLetterFour.text == nil || selectedLetterFour.text == "" {
            let caf = arr[3]
            selectedLetterFour.text = caf.description
        }
                
        numberOfTries += 1
    }
    
    @IBAction func handleTap(_ sender: UILongPressGestureRecognizer) {
        let state = sender.state
        let location = sender.location(in: self.collectionView)
        switch state {
        case .possible, .changed:
            if let indexPath: NSIndexPath = self.collectionView.indexPathForItem(at: location) as NSIndexPath?{
                if let cell = self.collectionView.cellForItem(at: indexPath as IndexPath) as? LetterCell{
                    self.handleCellSelection(cell: cell)
                }
            }
        case .ended:
            handleTapEnd()
            clearCells()

            isSameTry = false
        default:
            break
        }
        self.handleNumOfTries()
    }
    
    @IBAction func moreHintsAction(_ sender: Any) {
        if rewardedAd?.isReady == true {
           rewardedAd?.present(fromRootViewController: self, delegate: self)
        }
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
            pop.scorePointsLabel.text = String(DBManager.getScore())
        }
        
        delay(0.9) {
            self.clearCells()
            self.collectionView.reloadData()
        }
        numberOfTries = 0
    }

    func clearCells() {
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
                guard selectedSubject < gameModel.allSubjects.count else { return }
                
                gameModel?.subject = gameModel.allSubjects[selectedSubject]
                titleLabel.text = gameModel?.allSubjects.first { $0.rawValue == selectedSubject }?.name
            }
            
            guard let words = gameModel?.words[selectedSubject] else { return }
            
            self.words = words
            selectedWordPosition = 0
            DBManager.saveSubject(type: selectedSubject)
            DBManager.saveWord(word: selectedWordPosition)
        } else if DBManager.savedSubject() == selectedSubject, DBManager.getSavedWord() <= selectedWordPosition {
            DBManager.saveWord(word: selectedWordPosition)
            DBManager.saveScore(score: self.getTotalScore())
        }
    }
    
    private func getTotalScore() ->Int {
        if numberOfTries == 0 {
            return 28
        }
        else if numberOfTries == 1 {
            return 14
        }
        else if numberOfTries == 2 {
            return 8
        }
        else {
            return 4
        }
    }
    
    private func handleNumOfTries() {
        // check number of tries
        if selectedCells.count > 1 && !isSameTry
        {
            numberOfTries += 1
            isSameTry = true
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

extension GameViewController: GADRewardedAdDelegate {
    /// Tells the delegate that the user earned a reward.
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        DBManager.addHint()
        setupHintButton()
    }
    /// Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        print("Rewarded ad presented.")
    }
    /// Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        print("Rewarded ad dismissed.")
        self.rewardedAd = createAndLoadRewardedAd()
    }
    /// Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("Rewarded ad failed to present.")
    }
}
