//
//  FortuneViewController.swift
//  Fortune
//
//  Created by koya s on 2018/07/12.
//  Copyright © 2018 essochi. All rights reserved.
//

import UIKit

class FortuneViewController: UIViewController {
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var fortuneResult: UILabel! {
        didSet {
            fortuneResult.text = "あなたのおみくじの結果は..."
        }
    }
    @IBOutlet weak var fortuneResultButton: UIButton! {
        didSet {
            fortuneResultButton.setTitle("おみくじを引く", for: .normal)
            fortuneResultButton.tintColor = UIColor.white
            fortuneResultButton.backgroundColor = UIColor.black
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }()
    
    enum FortuneType: String {
        case great = "大吉"
        case good = "吉"
        case middle = "中吉"
        case small = "小吉"
        case uncertain = "末吉"
        case bad = "凶"
        case terrible = "大凶"
        
        static func getFortuneSelectedRamdomly() -> String {
            let fortuneBox = [FortuneType.great,
                              FortuneType.good,
                              FortuneType.middle,
                              FortuneType.small,
                              FortuneType.uncertain,
                              FortuneType.bad,
                              FortuneType.terrible]
            let index = Int(arc4random_uniform(UInt32(fortuneBox.count)))
            return fortuneBox[index].rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let now = Date()
        currentTime.text = dateFormatter.string(from: now)
        var time = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: "updateCurrentTime", userInfo: nil, repeats: true)
    }

    @IBAction func showFortuneResult(_ sender: Any) {
        fortuneResult.text = FortuneType.getFortuneSelectedRamdomly()
    }
    
    @objc private func updateCurrentTime() {
        let now = Date()
        currentTime.text = dateFormatter.string(from: now)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

