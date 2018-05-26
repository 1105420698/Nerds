//
//  ViewController.swift
//  Nerds
//
//  Created by Runkai Ken Nico Zhang on 12/20/17.
//  Copyright © 2017 Runkai Ken Nico Zhang. All rights reserved.
//
// IF ONE DAY SOME ONE FOUNED THIS, PLZ, FINISH IT

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

struct Global {
    static var shuffleResults = 0
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backgrounds: UIImageView!
    
    @IBOutlet weak var names: UITextView!
    
    @IBOutlet weak var onInfo: UIButton!
    
    @IBOutlet weak var nameBar: UIView!
    
    @IBOutlet weak var shuffleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let startSchool = String(0)
        historyList.append(startSchool)
        print(historyList)
        
        names.text = "Massachusetts Institution of Technology"
        
        let startUrl = URL(string: "http://numericdesign.org/Resources/0.jpg")
        
        backgrounds.kf.setImage(with: startUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var historyList = [String]()
    var shuffleCount = 1
    var finish = false
    var imageID = 0
    var infoID = Global.shuffleResults
    
    @IBAction func shuffleClicked(_ sender: Any) {
        shuffleCount = shuffleCount + 1
        Alamofire.request("http://numericdesign.org/services/schoolCountService.php").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let schoolCount = swiftyJsonVar[0]["count"].int {
                    var shuffleDetective = String(self.infoID)
                    
                    if self.shuffleCount <= schoolCount {
                        while self.historyList.contains(shuffleDetective) {
                            Global.shuffleResults = Int(arc4random_uniform(UInt32(schoolCount)))
                            self.infoID = Global.shuffleResults
                            shuffleDetective = String(self.infoID)
                        }
                        self.historyList.append(shuffleDetective)
                        print("History: \(self.historyList)")
                        print("The next university's id is \(self.infoID)")
                    }
                    else {
                        self.finish = true
                    }
                    
                    if self.finish == true {
                        print("You have looked through all the schools in our database!")
                        self.performSegue(withIdentifier: "finished", sender: self)
                    }
                    
                    self.imageID = self.infoID
                    let url = URL(string: "http://numericdesign.org/Resources/\(self.imageID).jpg")
                    
                    if self.finish == false {
                        self.imageID = self.infoID
                        print(self.imageID)
                        
                        self.backgrounds.kf.setImage(with: url)
                        
                        Alamofire.request("http://numericdesign.org/nameService.php").responseJSON { (responseData) -> Void in
                            if((responseData.result.value) != nil) {
                                let swiftyJsonVar = JSON(responseData.result.value!)
                                
                                if let name = swiftyJsonVar[0]["\(self.infoID)"].string {
                                    print(name)
                                    self.names.text = name
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
}
