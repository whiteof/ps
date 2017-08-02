//
//  ScriptsViewController.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/1/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ScriptsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let data: [String] = [
        "Abdominal Mass",
        "Abdominal Pain",
        "Anemia",
        "Bruising / petechiae",
        "Cough",
        "Diarrhea",
        "Fever and rash",
        "Fever without a focus",
        "Headache",
        "Heart murmur",
        "Hematuria",
        "Hepatomegaly",
        "Leukocoria, Red or Wandering Eye",
        "Limp",
        "Lymphadenopathy",
        "Otalgia",
        "Positive PPD",
        "Proteinuria",
        "Rash",
        "Rhinorrhea",
        "Seizure",
        "Sore throat",
        "Splenomegaly",
        "Vomiting"
    ]
    
    var filteredData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filteredData = self.data
        self.searchBar.barTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        self.searchBar.layer.borderWidth = 1
        self.searchBar.layer.borderColor = UIColor.white.cgColor
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchStr = self.searchBar.text {
            let searchStr = searchStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if searchStr.isEmpty {
                self.filteredData = self.data
            }else {
                self.filteredData = self.data.filter({(dataString: String) -> Bool in
                    return dataString.range(of: searchText, options: .caseInsensitive) != nil
                })
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScriptsCell", for: indexPath)
        for subview in cell.contentView.subviews {
            if subview.tag == 1 {
               subview.removeFromSuperview()
            }
        }
        cell.textLabel?.text = self.filteredData[indexPath.row]
        if indexPath.row != 0 {
            let separator = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0.5))
            separator.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
            separator.tag = 1
            cell.contentView.addSubview(separator)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let path = Bundle.main.path(forResource: "01", ofType: "json")
        do {
            let jsonString = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
            
            if let data = jsonString.data(using: String.Encoding.utf8.rawValue) {
                do {
                    if let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let question = jsonObj["question"] as? [String:Any] {
                            let questionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
                            questionViewController.currentQuestion = question
                            self.navigationController?.pushViewController(questionViewController, animated: true)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }catch {
            print("Not working!")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
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
