//
//  HowToUseViewController.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/2/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class HowToUseViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add labels
        var currentY:CGFloat = 20.0
        let frameWidth = self.view.frame.width - 40.0
        var label: UILabel!
        
        label = UIHelper.generateHeader("Welcome to PedScripts!  A tool to help medical students develop clinical reasoning skills in Pediatrics.")
        label.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label.getLabelHeight(byWidth: frameWidth))
        self.contentView.addSubview(label)
        currentY = currentY + label.frame.height + 20.0
        
        label = UIHelper.generateTextBold("Disclaimer: This WebApp is not intended for public use.  It is for educational purposes only.  For individual health concerns please see your health care provider.")
        label.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label.getLabelHeight(byWidth: frameWidth))
        self.contentView.addSubview(label)
        currentY = currentY + label.frame.height + 20.0

        label = UIHelper.generateTextRegular("PedScripts is intended to help students gather effective data at the point of patient care.\n\nCompared to expert clinicians, students are at a disadvantage because they don’t have a mental model for common conditions and how they present in the real world.  As a result, they may ask the wrong questions, perform the wrong exam, or omit key elements in data gathering.\n\nPedScripts will help students become familiar with illness scripts for real-world presentations so that they can gather the right data.\n\nBefore students see a patient in a clinical setting, they should review the appropriate algorithm and/or illness scripts for the presenting complaint (if available).\n\nIf the complaint includes a large number of illness scripts, students can narrow down to a few illness scripts by using the algorithm.\n\nIf the complaint includes a small number of illness scripts, students can simply review all of the available illness scripts.\n\nWhile reviewing the illness scripts, students should take note of important components of the history and physical exam that separate one script from another.  These are the key components of a focused history and physical exam for the patient.\n\nStudents can then begin the patient encounter with a better sense of how to approach differential diagnosis.")
        label.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label.getLabelHeight(byWidth: frameWidth))
        self.contentView.addSubview(label)
        currentY = currentY + label.frame.height + 20.0
        
        self.contentViewHeight.constant = currentY

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
