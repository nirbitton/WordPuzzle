//
//  WelcomeViewController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 23/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol WelcomeViewControllerDelegate: class {
    func welcomeViewController(controller: WelcomeViewController, didSelectStart: Bool)
    func welcomeViewController(controller: WelcomeViewController, didSelectAddHints: Bool)
}

class WelcomeViewController: UIViewController, Storyboarded {

    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var hintsCounterView: UIImageView!
    @IBOutlet weak var hintsCounterLabel: UILabel!
    
    var delegate: WelcomeViewControllerDelegate?
    var rewardedAd: GADRewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHintView()
        setupBackButton()
        setupAdMob()
    }
    
    func setupHintView() {
        let numberOfHints = DBManager.getSavedHint()
        guard numberOfHints > 0 else {
            counterView.isHidden = true
            return
        }
        
        counterView.isHidden = false
        hintsCounterView.addShadow()
        hintsCounterLabel.text = "\(numberOfHints)"
    }
    
    private func setupBackButton() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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

    @IBAction private func startAction(_ sender: Any) {
        delegate?.welcomeViewController(controller: self, didSelectStart: true)
    }

    @IBAction private func hintAction(_ sender: Any) {
        if rewardedAd?.isReady == true {
           rewardedAd?.present(fromRootViewController: self, delegate: self)
        }
    }
}

extension WelcomeViewController: GADRewardedAdDelegate {
    /// Tells the delegate that the user earned a reward.
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        DBManager.addHint()
        setupHintView()
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
