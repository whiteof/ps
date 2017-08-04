//
//  TabBarController.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/1/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard
        if let userDefaultsValue = userDefaults.object(forKey: "edu.cornell.weill.PedScripts.firstTimeUser") as? Bool {
            if userDefaultsValue != true {
                userDefaults.set(true, forKey: "edu.cornell.weill.PedScripts.firstTimeUser")
                userDefaults.synchronize()
                self.selectedIndex = 1
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
