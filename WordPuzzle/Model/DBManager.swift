//
//  DBManager.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 23/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import Foundation

class DBManager: NSObject {
        
    static let SAVED_LEVEL = "SAVED_LEVEL"
    static let SAVED_WORD = "SAVED_WORD"
    static let SAVED_SUBJECT = "SAVED_SUBJECT"
    
    static let EASY_SAVED_WORD = "EASY_SAVED_WORD"
    static let EASY_SAVED_SUBJECT = "EASY_SAVED_SUBJECT"
    
    static let HARD_SAVED_WORD = "HARD_SAVED_WORD"
    static let HARD_SAVED_SUBJECT = "HARD_SAVED_SUBJECT"
    
    static let NUM_OF_HINTS = "NUM_OF_HINTS"
    static let HINT_ALLREADY_SET = "HINT_ALLREADY_SET"
    static let SCORE = "SCORE"
    
    // ad unit name: "A letter hint"
    static let ADMOB_APP_ID = "ca-app-pub-1581642372941489~2561488580"
    static let ADMOB_AD_UNIT_ID = "ca-app-pub-1581642372941489/8944856119"
    
    static func saveLevel(level: Int) {
        UserDefaults().set(level, forKey: SAVED_LEVEL)
    }
    
    static func getSavedLevel() -> Int {
        UserDefaults().integer(forKey: SAVED_LEVEL)
    }
    
    //MARK: - Easy levels
    
    static func easySaveWord(word: Int) {
        UserDefaults().set(word, forKey: EASY_SAVED_WORD)
    }

    static func getEasySavedWord() -> Int {
        UserDefaults().integer(forKey: EASY_SAVED_WORD)
    }
    
    static func easySaveSubject(type: Int) {
        UserDefaults().set(type, forKey: EASY_SAVED_SUBJECT)
    }
    
    static func easySavedSubject() -> Int {
        UserDefaults().integer(forKey: EASY_SAVED_SUBJECT)
    }
    
    //MARK: - Advenced levels
    
    static func saveWord(word: Int) {
        UserDefaults().set(word, forKey: SAVED_WORD)
    }

    static func getSavedWord() -> Int {
        UserDefaults().integer(forKey: SAVED_WORD)
    }
    
    static func saveSubject(type: Int) {
        UserDefaults().set(type, forKey: SAVED_SUBJECT)
    }
    
    static func savedSubject() -> Int {
        UserDefaults().integer(forKey: SAVED_SUBJECT)
    }
    
    
    //MARK: - Hard levels
    
    
    static func hardSaveWord(word: Int) {
        UserDefaults().set(word, forKey: HARD_SAVED_WORD)
    }

    static func getHardSavedWord() -> Int {
        UserDefaults().integer(forKey: HARD_SAVED_WORD)
    }
    
    static func hardSaveSubject(type: Int) {
        UserDefaults().set(type, forKey: HARD_SAVED_SUBJECT)
    }
    
    static func hardSavedSubject() -> Int {
        UserDefaults().integer(forKey: HARD_SAVED_SUBJECT)
    }
    
    
    static func addHint(hint: Int = 1) {
        let uDefault = UserDefaults()
        let hint2 = hint + uDefault.integer(forKey: NUM_OF_HINTS)
        uDefault.set(hint2, forKey: NUM_OF_HINTS)
    }
    
    static func getSavedHint() -> Int {
        return UserDefaults().integer(forKey: NUM_OF_HINTS)
    }
    
    static func isHintAllreadySet() -> Bool {
        return UserDefaults().bool(forKey: HINT_ALLREADY_SET)
    }
    
    static func setBooleanHintAsTrue() {
        UserDefaults().set(true, forKey: HINT_ALLREADY_SET)
    }
    
    static func saveScore(score: Int) {
        var curr = self.getScore()
        curr = curr + score
        UserDefaults().set(curr, forKey: SCORE)
    }
    
    static func getScore() -> Int {
        return UserDefaults().integer(forKey: SCORE)
    }
}
