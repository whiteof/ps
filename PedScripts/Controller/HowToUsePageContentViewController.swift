//
//  HowToUsePageContentViewController.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/4/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class HowToUsePageContentViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomEdge: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.containerView.layer.borderWidth = 1.5
        self.containerView.layer.cornerRadius = 8.0
        self.containerView.layer.borderColor = UIColor(red: 93/255, green: 160/255, blue: 209/255, alpha: 0.5).cgColor
        
        self.contentViewHeight.constant = self.bottomEdge.frame.origin.y
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
