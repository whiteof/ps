//
//  QuestionViewController.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/2/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let path = Bundle.main.path(forResource: "01", ofType: "json")
        do {
            let jsonString = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
            
            if let data = jsonString.data(using: String.Encoding.utf8.rawValue) {
                do {
                    if let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let diseaseEntity = Disease()
                        diseaseEntity.id = (jsonObj["id"] as! NSString).integerValue
                        diseaseEntity.title = jsonObj["title"] as! String
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }catch {
            print("Not working!")
        }
        
        
        
        
        
        /*

        */
        
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
