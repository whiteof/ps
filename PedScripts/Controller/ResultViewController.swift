//
//  ResultViewController.swift
//  PedScripts
//
//  Created by Viktar Yurkin on 8/2/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var diseaseLabel: UILabel!
    
    var result: [String:Any]!
    var diseaseTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.diseaseLabel.text = self.diseaseTitle.uppercased()
        // change back button
        let backImage = UIImage(named: "Navbar Button Back")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navbar Button Back"), style: .plain, target: self, action: #selector(self.backAction(_:)))
        // add close button
        let closeButton = UIBarButtonItem(image: UIImage(named: "Navbar Button Close"), style: .plain, target: self, action: #selector(self.closeAction(_:)))
        self.navigationItem.rightBarButtonItem = closeButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }else {
            if let script = self.result["script"] as? [String:Any] {
                if let values = script["values"] as? [[String:Any]] {
                    return values.count
                }
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var text: String = ""
        if indexPath.section == 0 {
            if let title = self.result["title"] as? String {
                text = title
            }
        }else {
            if let script = self.result["script"] as? [String:Any] {
                if let values = script["values"] as? [[String:Any]] {
                    let value = values[indexPath.row]
                    if let title = value["title"] as? String {
                        text = title
                    }
                }
            }
        }
        
        let frameWidth = self.view.frame.width - 60.0
        let label = UIHelper.generateHeader(text)
        label.frame = CGRect(x: 0.0, y: 0.0, width: frameWidth, height: label.getLabelHeight(byWidth: frameWidth))
        
        if indexPath.section == 0 {
            return label.frame.height + 60.0
        }
        return label.frame.height + 40.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        // remove separator
        for subview in cell.contentView.subviews {
            if subview.tag == 1 {
                subview.removeFromSuperview()
            }
        }
        
        if indexPath.section == 0 {
            if let title = self.result["title"] as? String {
                if let textLabel = cell.textLabel {
                    textLabel.text = title
                    textLabel.font = UIHelper.questionFont
                    textLabel.numberOfLines = 0
                    textLabel.frame = CGRect(x: textLabel.frame.origin.x, y: textLabel.frame.origin.y, width: textLabel.frame.width, height: textLabel.getLabelHeightByWidth())
                }
            }
            // add image
            cell.imageView?.image = UIImage(named: "Result Table Cell Icon")
            cell.imageView?.alpha = 0.3
            
            if let diseaseId = self.result["disease_id"] as? String {
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .default
            }else {
                cell.accessoryType = .none
                cell.selectionStyle = .none
            }
        }else {
            //set title
            if let script = self.result["script"] as? [String:Any] {
                if let values = script["values"] as? [[String:Any]] {
                    let value = values[indexPath.row]
                    if let title = value["title"] as? String {
                        if let textLabel = cell.textLabel {
                            textLabel.text = title
                            textLabel.font = UIHelper.answerFont
                            textLabel.textColor = UIHelper.answerColor
                            textLabel.numberOfLines = 0
                            textLabel.frame = CGRect(x: textLabel.frame.origin.x, y: textLabel.frame.origin.y, width: textLabel.frame.width, height: textLabel.getLabelHeightByWidth())
                        }
                    }
                }
            }
            // add image
            cell.imageView?.image = UIImage(named: "Answer Table Cell Icon")
            cell.imageView?.alpha = 0.8
        }
        
        // add separator
        let separator = UIView(frame: CGRect(x: 0, y: cell.contentView.frame.height-1.0, width: self.view.frame.width, height: 0.5))
        separator.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        separator.tag = 1
        cell.contentView.addSubview(separator)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        if indexPath.section == 0 && cell.accessoryType == .disclosureIndicator  {
            self.performSegue(withIdentifier: "unwindToScripts", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        }else if indexPath.section == 1 {
            if let script = self.result["script"] as? [String:Any] {
                if let values = script["values"] as? [[String:Any]] {
                    let value = values[indexPath.row]
                    let scriptViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScriptValueViewController") as! ScriptValueViewController
                    scriptViewController.diseaseTitle = self.diseaseTitle
                    if let title = value["title"] as? String {
                        scriptViewController.titleValue = title
                    }
                    if let description = value["description"] as? String {
                        scriptViewController.descriptionValue = description
                    }
                    self.navigationController?.pushViewController(scriptViewController, animated: true)
                }
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func closeAction(_ sender:UIBarButtonItem){
        self.performSegue(withIdentifier: "unwindToScripts", sender: self)
    }
    
    @objc func backAction(_ sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }

}
