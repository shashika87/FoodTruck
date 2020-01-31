//
//  FoodTruckTableViewController.swift
//  FoodTruck
//
//  Created by Shashi Kant on 1/28/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit

class FoodTruckTableViewController: UITableViewController {

    var resultArray : [FoodTruckItem]? = [];
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Food Trucks"
        
        let parentView = self.navigationController!.view!
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
        ])
        
        self.navigationController?.view.addSubview(activityIndicator)
        
        let apiClient = APIClient();
        apiClient.getHttpFoodTrucK(requestURL: "https://data.sfgov.org/resource/jjew-r69b.json",  completion:{ result in
            self.resultArray?.append(contentsOf: result);
            self.resultArray?.sort(by:{ $0.applicant! < $1.applicant! })
            let timeZone = TimeZone(abbreviation: "PST")
            let component =  Calendar.current.dateComponents(in: timeZone!, from: Date())
            let weekday = "\( component.weekday!)"
            let calendar = Calendar.current
            let date = Date()
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            print("\(hour):\(minutes)")
            let currentTime = "\(hour):\(minutes)"
            let utilFoodTruck = UtilFoodTruck();
            let timeInMinutesForCurrentTime = utilFoodTruck.getTimeAsNumberOfMinutes(time: currentTime)
            self.resultArray = self.resultArray?.filter {
                ($0.dayorder == weekday) && (utilFoodTruck.getTimeAsNumberOfMinutes(time: $0.start24!) < timeInMinutesForCurrentTime && utilFoodTruck.getTimeAsNumberOfMinutes(time: $0.end24!) > timeInMinutesForCurrentTime) }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                activityIndicator.stopAnimating()
            }
        })
        
        self.tableView.estimatedRowHeight = 80;
        self.tableView.rowHeight = UITableView.automaticDimension;
    }
    
    
    
  
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.resultArray!.count
    }
    
    //

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LocationCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationCell
        let foodTruckItem :FoodTruckItem = self.resultArray![indexPath.row]
        cell.nameLabel?.text = foodTruckItem.applicant
        cell.addressLabel?.text = foodTruckItem.location
        cell.addressLabel?.text = cell.addressLabel?.text?.uppercased()
        cell.menuLabel?.text = foodTruckItem.optionaltext
        cell.hoursLabel?.text = "\(foodTruckItem.starttime!) - \(foodTruckItem.endtime!)"
        
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let foodTruckItem :FoodTruckItem = self.resultArray![indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mapViewController : MapViewController = storyboard.instantiateViewController(withIdentifier: "sb_mapviewcontroller") as! MapViewController
        mapViewController.foodTrucksArray = self.resultArray
        mapViewController.locationId = foodTruckItem.locationid
        self.navigationController?.pushViewController(mapViewController, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_mapviewcontroller") {
            let mapViewController = segue.destination as! MapViewController
            mapViewController.foodTrucksArray = self.resultArray
            if(resultArray!.count > 0){
                let foodTruckItem : FoodTruckItem = self.resultArray![0]
                mapViewController.locationId = foodTruckItem.locationid
            }
        }
    }
    
    


    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}
