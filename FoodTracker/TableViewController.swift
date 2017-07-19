//
//  TableViewController.swift
//  FoodTracker
//
//  Created by Hung Nguyen on 7/19/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.shared.updateMeal()
        self.navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = 90
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataService.shared.meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell

        cell.mealName.text = DataService.shared.meals[indexPath.row].name
        cell.mealImage.image = DataService.shared.meals[indexPath.row].image as! UIImage?
        cell.ratingControl.rating = Int(DataService.shared.meals[indexPath.row].rating)
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            DataService.shared.deleteMeal(index: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add"{
            guard let rootVC  = segue.destination as? UINavigationController else { return }
            guard let mealDetailVC = rootVC.viewControllers.first as? MealViewController else { return }
            mealDetailVC.segueStatus = "add"
        }
        
        if segue.identifier == "edit"{
            guard let detailVC = segue.destination as? MealViewController else { return }
            guard let selected = sender as? CustomCell else { return }
            guard let indexPath = tableView.indexPath(for: selected) else { return }
            detailVC.index = indexPath
            detailVC.segueStatus = "edit"
        }
    }
}
