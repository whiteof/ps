//
//  QuestionViewController.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/2/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var diseaseLabel: UILabel!
    
    var currentQuestion: [String:Any]?
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
            if let question = self.currentQuestion {
                if let answers = question["answers"] as? [[String:Any]] {
                    return answers.count
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var text: String = ""
        if indexPath.section == 0 {
            if let question = self.currentQuestion {
                if let title = question["title"] as? String {
                    text = title
                }
            }
        }else {
            if let question = self.currentQuestion {
                if let answers = question["answers"] as? [[String:Any]] {
                    let answer = answers[indexPath.row]
                    if let title = answer["title"] as? String {
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        
        // remove separator
        for subview in cell.contentView.subviews {
            if subview.tag == 1 {
                subview.removeFromSuperview()
            }
        }
        
        if indexPath.section == 0 {
            if let question = self.currentQuestion {
                if let title = question["title"] as? String {
                    if let textLabel = cell.textLabel {
                        textLabel.text = title
                        textLabel.font = UIHelper.questionFont
                        textLabel.numberOfLines = 0
                        textLabel.frame = CGRect(x: textLabel.frame.origin.x, y: textLabel.frame.origin.y, width: textLabel.frame.width, height: textLabel.getLabelHeightByWidth())
                    }
                }
            }
            // add image
            cell.imageView?.image = UIImage(named: "Question Table Cell Icon")
            cell.imageView?.alpha = 0.3
            // disable selecting
            cell.selectionStyle = .none
        }else {
            //set title
            if let question = self.currentQuestion {
                if let answers = question["answers"] as? [[String:Any]] {
                    let answer = answers[indexPath.row]
                    if let title = answer["title"] as? String {
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
        if indexPath.section == 1 {
            if let question = self.currentQuestion {
                if let answers = question["answers"] as? [[String:Any]] {
                    let answer = answers[indexPath.row]
                    if let subQuestion = answer["question"] as? [String:Any] {
                        let questionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
                        questionViewController.currentQuestion = subQuestion
                        questionViewController.diseaseTitle = self.diseaseTitle
                        self.navigationController?.pushViewController(questionViewController, animated: true)
                    }else if let result = answer["result"] as? [String:Any] {
                        let resultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                        resultViewController.result = result
                        resultViewController.diseaseTitle = self.diseaseTitle
                        self.navigationController?.pushViewController(resultViewController, animated: true)
                    }
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
