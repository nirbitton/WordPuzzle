//
//  GameModel.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 23/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import Foundation
import GoogleMobileAds

class GameModel {
    enum Level: Int {
        case easy, medium, hard
    }
    
    enum SubjectType: Int {
        case  animals, names, colors, food, humanBody, countries, bible, professions
        
        var name: String {
            switch self {
            case .animals:
                return "חיות"
            case .names:
                return "שמות"
            case .colors:
                return "צבעים"
            case .food:
                return "מאכלים"
            case .humanBody:
                return "גוף האדם"
            case .countries:
                return "מדינות"
            case .bible:
                return "תנ״ך"
            case .professions:
                return "מקצועות"
            }
        }
        
        var icon: String {
            switch self {
            case .animals:
                return "icPurpule"
            case .names:
                return "icLightBBlue"
            case .colors:
                return "icBlue"
            case .food:
                return "icRed"
            case .humanBody:
                return "icGreen"
            case .countries:
                return "icOrange"
            case .bible:
                return "icBlue"
            case .professions:
                return "icLightBBlue"
            }
        }
        
        static var all = [animals, names, colors, food, humanBody, countries, bible, professions]
    }

    var level: Level = .easy
    var subject: SubjectType = .animals
    var allSubjects = SubjectType.all
    var words = [[String]]()
    var wordIcon = "icWordCell"

    init() {
        initWords()
        initHints()
    }
    
    private func initWords() {
        words.removeAll()
        let animals = ["אריה","תנינ","נמלה","זבוב","יתוש","לטאה","עכבר","חתול","שועל","חמור","פרפר"]
        let names = ["ימית","לביא","בארי","אביה","דפנה","איתנ","מאיר","יוספ","ברוכ","אסתר","יקיר","הילה","תומר","רוננ","בתיה","דרור","כרמל","ירדנ","מרימ","אמיר","שרונ","מיקי","יאיר"]
        let colors = ["אדומ","צהוב","ירוק","כחול","שחור","כתומ","ורוד","תכלת","סגול","ציאנ","אפור"]
        let food = ["פיצה","במבה","ביצה","פסטה","חציל","גמבה","פיתה","ציפס","תפוח","חלבה","טוסט","מעדנ","עוגה","כרוב"]
        let body = ["אוזנ","מרפק","לשונ","אצבע","פנימ","טבור","זרוע","ריאה","בוהנ"]
        let countries = ["גאנה","בליז","בנינ","הודו","יוונ","ירדנ","לאוס","ליטא","מאלי","מלטה","נפאל","סנגל","ספרד","פנמה","צרפת","קנדה","קניה","תימנ"]
        let bible = ["תורה","שמות","הושע","יואל","בארי","עמוס","יונה","מיכה","נחומ","משלי","איוב","איכה","קהלת","אסתר","שלמה","עזרא","רבקה","פרעה","יצחק","נביא","עשיו","שאול","בעשא","אחאב","יעקב"]
        let professions = ["רופא","מורה","מנהל","אופה","אספנ","בלדר","בלשנ","בנאי","במאי","שוטר","מציל","כבאי","זבלנ","ברמנ","גובה","חבלנ","מרגל","משרת","סוהר","ליצנ","חזאי","מאלפ","מדענ","חלבנ","גזבר","מלצר","מנחה","צורפ","פקיד","מנתח","יועצ","הגאי","יחצנ","מנקה","רוקח","קלדנ","ספרנ","פועל","מכשפ","חלפנ","סוכנ","חובש","סופר","קוסמ","רקדנ","ימאי","מעצב","חובל","ירקנ","סריס","שחקנ","תופר","מנצח","גולש","חקינ","שומר","משיט","כורת","חדשנ","חותר","חרזנ"]
        
        
        words.append(animals)
        words.append(names)
        words.append(colors)
        words.append(food)
        words.append(body)
        words.append(countries)
        words.append(bible)
        words.append(professions)
    }
    
    private func initHints() {
        guard !DBManager.isHintAllreadySet() else { return }
        
        DBManager.setBooleanHintAsTrue()
        DBManager.addHint(hint: 3)
    }
}
