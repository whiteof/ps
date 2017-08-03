//
//  ScriptValueViewController.swift
//  PedScripts
//
//  Created by Viktar Yurkin on 8/2/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ScriptValueViewController: UIViewController {
    
    @IBOutlet weak var diseaseLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    var diseaseTitle:String = ""
    var titleValue:String = ""
    var descriptionValue:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.diseaseLabel.text = self.diseaseTitle.uppercased()
        // add close button
        //let closeButton = UIBarButtonItem(image: UIImage(named: "imagename"), style: .plain, target: self, action: Selector("action"))
        let closeButton = UIBarButtonItem.init(title: "Close", style: .plain, target: self, action: #selector(self.closeAction(_:)))
        self.navigationItem.rightBarButtonItem = closeButton

        var label = UILabel()
        var currentY:CGFloat = 20.0
        let frameWidth = self.view.frame.width - 40.0
        label = UIHelper.generateHeader(self.titleValue)
        label.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label.getLabelHeight(byWidth: frameWidth))
        self.contentView.addSubview(label)
        currentY = currentY + label.frame.height + 20.0
        
        label = UIHelper.generateTextRegular(self.descriptionValue)
        label.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label.getLabelHeight(byWidth: frameWidth))
        self.contentView.addSubview(label)
        currentY = currentY + label.frame.height + 20.0

        self.contentViewHeight.constant = currentY
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func closeAction(_ sender:UIBarButtonItem){
        self.performSegue(withIdentifier: "unwindToScripts", sender: self)
    }

}
