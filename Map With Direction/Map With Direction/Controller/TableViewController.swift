//
//  TableViewController.swift
//  Map With Direction
//
//  Created by Mac on 9/25/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    var londonLandmarks = [LondonLandmark]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "goToShowDetail":
            
            guard let detailViewController = segue.destination as? DetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            let selectedRow = (sender as! NSIndexPath).row
            let selectedLandmark = londonLandmarks[selectedRow]
            detailViewController.londonLandmark = selectedLandmark
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
}

// MARK: - UITableViewDelegate
extension TableViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell Clicked")
        self.performSegue(withIdentifier: "goToShowDetail", sender: indexPath)
       
    }
}

// MARK: - UITableViewDataSource
extension TableViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return londonLandmarks.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "londonLandmarkCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LondonLandmarkCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let landmark = londonLandmarks[indexPath.row]
        cell.name.text = landmark.name
        cell.postalCode.text = landmark.postalCode
        cell.photoImage.image = UIImage.init(named: landmark.photo)
        
        return cell
    }
}

