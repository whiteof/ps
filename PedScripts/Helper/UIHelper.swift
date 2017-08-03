//
//  UIHelper.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/2/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class UIHelper {
    
    static let textColor:UIColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
    static let textFontRegular:UIFont = UIFont(name:"HelveticaNeue", size: 16.0)!
    static let textFontBold:UIFont = UIFont(name:"HelveticaNeue-Bold", size: 16.0)!
    
    static let headerColor:UIColor = UIColor(red: 93/255, green: 160/255, blue: 209/255, alpha: 1.0)
    static let headerFont:UIFont = UIFont(name:"HelveticaNeue-Bold", size: 20.0)!
    
    static let subHeaderColor:UIColor = UIColor(red: 93/255, green: 160/255, blue: 209/255, alpha: 1.0)
    static let subHeaderFont:UIFont = UIFont(name:"HelveticaNeue", size: 16.0)!
    
    static let buttonFont:UIFont = UIFont(name:"HelveticaNeue", size: 16.0)!
    static let buttonColor:UIColor = UIColor(red: 0/255, green: 122/255, blue: 225/255, alpha: 1.0)
    
    static let questionColor:UIColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
    static let questionFont:UIFont = UIFont(name:"HelveticaNeue", size: 20.0)!

    static let answerColor:UIColor = UIColor(red: 93/255, green: 160/255, blue: 209/255, alpha: 1.0)
    static let answerFont:UIFont = UIFont(name:"HelveticaNeue", size: 18.0)!

    class func generateHeader(_ text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.text = text
        label.font = UIHelper.headerFont
        label.textColor = UIHelper.headerColor
        return label
    }
    
    class func generateTextRegular(_ text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.text = text
        label.font = UIHelper.textFontRegular
        label.textColor = UIHelper.textColor
        return label
    }

    class func generateTextBold(_ text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.text = text
        label.font = UIHelper.textFontBold
        label.textColor = UIHelper.textColor
        return label
    }

}
