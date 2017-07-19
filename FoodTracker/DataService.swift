//
//  DataService.swift
//  FoodTracker
//
//  Created by Hung Nguyen on 7/19/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let shared: DataService = DataService()
    
    private var _meals: [Meal]?
    var meals: [Meal]!
    
    func updateMeal(){
        _meals = try! Database.viewContext().fetch(Meal.fetchRequest())
        meals = _meals
    }
    
    func addMeal(name: String, image: UIImage, rating: Int){
        let meal = Meal(context: Database.viewContext())
        meal.name = name
        meal.image = image
        meal.rating = Int16(rating)
        Database.saveContext()
        meals.append(meal)
    }
    
    func deletemeal(index: IndexPath){
        let meal = meals[index.row]
        meals.remove(at: index.row)
        Database.viewContext().delete(meal)
    }
}
