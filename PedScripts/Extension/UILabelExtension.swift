//
//  UILabelExtension.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/2/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

extension UILabel {
    
    func getLabelHeightByWidth() -> CGFloat {
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        tempLabel.numberOfLines = 0
        tempLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        tempLabel.font = self.font
        tempLabel.text = self.text
        tempLabel.sizeToFit()
        return tempLabel.frame.height
    }
    
    func getLabelHeight(byWidth: CGFloat) -> CGFloat {
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: byWidth, height: CGFloat.greatestFiniteMagnitude))
        tempLabel.numberOfLines = 0
        tempLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        tempLabel.font = self.font
        tempLabel.text = self.text
        tempLabel.sizeToFit()
        return tempLabel.frame.height
    }
    
    static func generateFormattedText(content: [Dictionary<String, UIFont>]) -> NSMutableAttributedString {
        let returnContent = NSMutableAttributedString()
        for item in content {
            let dictKeys = item.keys
            let formattedText = NSMutableAttributedString(string:dictKeys.first!, attributes:[NSAttributedStringKey.font : item[dictKeys.first!]!])
            returnContent.append(formattedText)
        }
        return returnContent
    }
    
}

