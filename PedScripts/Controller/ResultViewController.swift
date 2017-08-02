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
    
    var result: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.result)
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
        if let script = self.result["script"] as? [String:Any] {
            if let values = script["values"] as? [[String:Any]] {
                return values.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerCell = tableView.dequeueReusableCell(withIdentifier: "ResultHeaderCell") {
            if let title = self.result["title"] as? String {
                headerCell.textLabel?.text = title
            }
            return headerCell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        if let script = self.result["script"] as? [String:Any] {
            if let values = script["values"] as? [[String:Any]] {
                let value = values[indexPath.row]
                if let title = value["title"] as? String {
                    cell.textLabel?.text = title
                }
            }
        }
        return cell
    }

}
