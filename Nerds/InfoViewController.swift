//
//  InfoViewController.swift
//  Nerds
//
//  Created by Runkai Ken Nico Zhang on 2/15/18.
//  Copyright © 2018 Runkai Ken Nico Zhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InfoViewController: UIViewController {
    
    let infoID = Global.shuffleResults
    @IBOutlet weak var infoText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


            print("Global variable:\(infoID)")
        
            Alamofire.request("http://numericdesign.org/infoService.php").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                    
                if let info = swiftyJsonVar[0]["id_\(self.infoID)"].string {
                    print(info)
                    self.infoText.text = info
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
