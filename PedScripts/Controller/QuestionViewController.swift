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
    
    var currentQuestion: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let question = self.currentQuestion {
            if let answers = question["answers"] as? [[String:Any]] {
                return answers.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerCell = tableView.dequeueReusableCell(withIdentifier: "QuestionHeaderCell") {
            if let question = self.currentQuestion {
                if let title = question["title"] as? String {
                    headerCell.textLabel?.text = title
                }
            }
            return headerCell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        
        if let question = self.currentQuestion {
            if let answers = question["answers"] as? [[String:Any]] {
                let answer = answers[indexPath.row]
                if let title = answer["title"] as? String {
                    cell.textLabel?.text = title
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let question = self.currentQuestion {
            if let answers = question["answers"] as? [[String:Any]] {
                let answer = answers[indexPath.row]
                if let subQuestion = answer["question"] as? [String:Any] {
                    let questionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
                    questionViewController.currentQuestion = subQuestion
                    self.navigationController?.pushViewController(questionViewController, animated: true)
                }else if let result = answer["result"] as? [String:Any] {
                    let resultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    resultViewController.result = result
                    self.navigationController?.pushViewController(resultViewController, animated: true)
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
