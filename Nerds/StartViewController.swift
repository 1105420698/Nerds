//
//  StartViewController.swift
//  Nerds
//
//  Created by Runkai Ken Nico Zhang on 1/2/18.
//  Copyright © 2018 Runkai Ken Nico Zhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StartViewController: UIViewController {
    
    var update_results = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
 
    @IBAction func start(_ sender: Any) {
        
        Alamofire.request("http://numericdesign.org/services/updateService.php").responseJSON { (responseData) -> Void in
            //Make sure the data is processed only if the data is not an empty string
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let update_result = swiftyJsonVar[0]["update_light"].string {
                    print(update_result)
                    
                    if update_result == "false" {
                        self.update_results = false
                    }
                    
                    if update_result == "true" {
                        self.update_results = true
                    }
                    
                    if self.update_results == false {
                        self.performSegue(withIdentifier: "starter", sender: self)
                    }
                    if self.update_results == true {
                        let alert = UIAlertController(title: "Updates", message: "There is an updates available!", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "To App Store!", style: .default, handler: {action in UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
                        }))
                        self.present(alert, animated: true)
                    }
                }
                }
            }
        }
    
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
