//
//  WhoWeAreViewController.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/2/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class WhoWeAreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let sections = ["Project Lead", "Site Design", "Contributors"]
    
    let rows = [
        0: [
            ["Jonathan Gold, MD, FAAP", "Michigan State University College of Human Medicine"]
        ],
        1: [
            ["Philip Malouf, MD, FAAP", "Touro University College of Osteopathic Medicine"]
        ],
        2: [
            ["Julia Belkowitz, MD, FAAP", "University of Miami Miller School of Medicine"],
            ["Kristen Bettin, MD, MEd, FAAP", "University of Tennessee Health Center"],
            ["Parul Bhatia, MD, FAAP", "USC Keck School of Medicine at Childrens Hospital Los Angeles"],
            ["Yvonne Blasini, MD", "Ponce School of Medicine"],
            ["Nydia Bonet-Jordan, MD", "University of Puerto Rico, School of Medicine"],
            ["Harris E. Burstin, MD, FAAP", "NYU School of Medicine"],
            ["Gabrina L. Dixon, MD, FAAP", "Children's National Health System, George Washington University"],
            ["Steven Eagle, MD", "The Children's Hospital at Montefiore"],
            ["Rana El Feghaly, MD", "University of Mississippi Medical Center, Jackson, MS"],
            ["James W. Fox, MD, FAAP", "Duke University School of Medicine"],
            ["Jeanne Hayes, MD", "University of Oklahoma - Tulsa"],
            ["MacKenzi Hillard, MD, MHPE", "Weill Cornell Medical College"],
            ["Harry Hoar, MD", "Baystate Medical Center"],
            ["Jeff Lancaster, MD", "West Virginia University School of Medicine"],
            ["Lisa E. Leggio, MD, FAAP", "Medical College of Georgia at Georgia Regents University"],
            ["Kyra Len, MD, FAAP", "University of Hawaii, John A. Burns School of Medicine"],
            ["Leonard Levine, MD", "St. Christopher's Hospital for Children, Drexel University College of Medicine"],
            ["Brian Lurie, MD, MPH", "Atlantic Health - Goryeb Children's Hospital, Morristown, NJ"],
            ["Tsee Foong Loh, MBBS MMed", "KK Hospital, Singapore"],
            ["Erin McMaster, MD, FAAP", "University of Massachusetts Medical School"],
            ["Penny Murata, MD", "University of California, Irvine"],
            ["Andrew Mutnick, MD", "Childrens Hospital of New York, Columbia University"],
            ["Molly Rideout, MD, FAAP", "University of Vermont Children's Hospital"],
            ["Melissa Sanchez, MD", "University of New Mexico"],
            ["Miriam Schechter, MD, FAAP", "Albert Einstein College of Medicine"],
            ["Chandler Todd, MD, FAAP", "University of New Mexico School of Medicine"],
            ["Adam R. Weinstein, MD", "Geisel School of Medicine at Dartmouth"]
        ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let rowsSection = self.rows[section] {
            return rowsSection.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhoWeAreCell", for: indexPath)
        if let section = self.rows[indexPath.section] {
            cell.textLabel?.text = section[indexPath.row][0]
            cell.detailTextLabel?.text = section[indexPath.row][1]
        }
        return cell
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
