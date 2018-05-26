//
//  ViewController.swift
//  Nerds
//
//  Created by Runkai Ken Nico Zhang on 12/20/17.
//  Copyright © 2017 Runkai Ken Nico Zhang. All rights reserved.
//

import UIKit
//import Kingfisher
import Alamofire
import SwiftyJSON

struct shuffleResultsVariable {
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
        
        //backgrounds.kf.setImage(with: startUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let schoolCount = 3
    var historyList = [String]()
    var shuffleCount = 1
    var finish = false
    var imageID = 0
    var infoID = shuffleResultsVariable.shuffleResults
    
    @IBAction func shuffleClicked(_ sender: Any) {
        shuffleCount = shuffleCount + 1
        
        var shuffleDetective = String(infoID)
        
        if shuffleCount <= schoolCount {
            while historyList.contains(shuffleDetective) {
                shuffleResultsVariable.shuffleResults = Int(arc4random_uniform(UInt32(schoolCount)))
                infoID = shuffleResultsVariable.shuffleResults
                shuffleDetective = String(infoID)
            }
            historyList.append(shuffleDetective)
            print("History: \(historyList)")
            print("The next university's id is \(infoID)")
        }
        else {
            finish = true
        }
        
        if finish == true {
            print("You have looked all the schools!")
            self.performSegue(withIdentifier: "finished", sender: self)
        }
        
        imageID = infoID
        let url = URL(string: "http://numericdesign.ddns.net/Resources/\(imageID).jpg")
        
        if finish == false {
            imageID = infoID
            print(imageID)
            
            //backgrounds.kf.setImage(with: url)
            
            Alamofire.request("http://numericdesign.ddns.net/nameService.php").responseJSON { (responseData) -> Void in
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
