//
//  NutritionDetailViewController.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/6/23.
//

import Foundation
import UIKit
import CoreData


protocol NutritionDetailViewControllerDelegate: AnyObject {
    func didTapOnButton()
}

class NutritionDetailViewController: UIViewController, NSFetchedResultsControllerDelegate {
    var nutrition: Nutrition!
    var nutritionDetail = NutritionDetailView()
    var dataController: DataController!
    var fetchedResultsController:NSFetchedResultsController<LogItem>!
    var dateFormated: String!
    weak var delegate: NutritionDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFetchedResutlController()
        view.backgroundColor = Constance.beige
        configureNavigationBar()
        addSubviews()
        nutritionDetail.button1.addTarget(self, action: #selector(self.button1Clicked), for: .touchUpInside)
        nutritionDetail.button2.addTarget(self, action: #selector(self.button2Clicked), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frame
        nutritionDetail.text1.frame = CGRect(x: 30,
                                             y: view.safeAreaInsets.top,
                                             width: view.width - 20,
                                             height: 40)
        nutritionDetail.text1.text = "\u{2022} Calories: \(nutrition.calories)"
        
        nutritionDetail.text2.frame = CGRect(x: 30,
                                             y: nutritionDetail.text1.bottom,
                                             width: view.width - 20,
                                             height: 40)
        nutritionDetail.text2.text = "\u{2022} Fat total (g): \(nutrition.fatTotal)"
        
        nutritionDetail.text3.frame = CGRect(x: 30,
                                             y: nutritionDetail.text2.bottom,
                                             width: view.width - 20,
                                             height: 40)
        nutritionDetail.text3.text = "\u{2022} Protein total (g): \(nutrition.protein)"
        
        nutritionDetail.text4.frame = CGRect(x: 30,
                                             y: nutritionDetail.text3.bottom,
                                             width: view.width - 20,
                                             height: 40)
        nutritionDetail.text4.text = "\u{2022} Carbohydrates total (g): \(nutrition.carbohydratesTotal)"
        
        nutritionDetail.text5.frame = CGRect(x: 30,
                                             y: nutritionDetail.text4.bottom,
                                             width: view.width - 20,
                                             height: 40)
        nutritionDetail.text5.text = "\u{2022} Fiber total (g): \(nutrition.fiber)"
        
        nutritionDetail.text6.frame = CGRect(x: 30,
                                             y: nutritionDetail.text5.bottom + 10,
                                             width: view.width - 60,
                                             height: 40)
        nutritionDetail.text6.text = "Would you like adding it to today's food list?"
        nutritionDetail.text6.textAlignment = .center
        
        nutritionDetail.button1.frame = CGRect(x: view.width/2 - 60, y: nutritionDetail.text6.bottom + 10, width: 120, height: 30)
        nutritionDetail.button2.frame = CGRect(x: view.width/2 - 60, y: nutritionDetail.button1.bottom + 20, width: 120, height: 30)
        
    }
    
    @objc func button1Clicked(sender: UIButton) {
        // save new food data into UserDefaults
        var foodList = UserDefaults.standard.array(forKey: "foodItems")
        foodList?.append(nutrition.name)
        var caloriesList = UserDefaults.standard.array(forKey: "calories")
        caloriesList?.append(nutrition.calories)
        
        UserDefaults.standard.set(foodList, forKey: "foodItems")
        UserDefaults.standard.set(caloriesList, forKey: "calories")
        
        var totalCalories = 0.0
        if let caloriesList = caloriesList {
            for calories in caloriesList {
                totalCalories += calories as! Double
            }
        }
        
        addNewOrUpdateCurrentDayEntry(totalCalories)
        
        delegate?.didTapOnButton()
        dismiss(animated: true)
    }
    
    @objc func button2Clicked(sender: UIButton) {
        dismiss(animated: true)
    }
    
    func configureFetchedResutlController() {
        let fetchRequest: NSFetchRequest<LogItem> = LogItem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // search today's entry
        let dateFormated = Utils.getFormatedDate(date: Date())
        fetchRequest.predicate = NSPredicate(format: "date = '\(dateFormated)'")
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    fileprivate func addNewOrUpdateCurrentDayEntry(_ totalCalories: Double) {
        // update the last entry if existing
        if fetchedResultsController.fetchedObjects?.count != 0,  let object = fetchedResultsController.fetchedObjects?[0] {
            object.setValue(totalCalories, forKey: "calories")
        } else {
            let logItem = LogItem(context: dataController.viewContext)
            logItem.calories = totalCalories
            logItem.date = Utils.getFormatedDate(date: Date())
        }
        try? dataController.viewContext.save()
    }
    
    private func addSubviews() {
        view.addSubview(nutritionDetail.text1)
        view.addSubview(nutritionDetail.text2)
        view.addSubview(nutritionDetail.text3)
        view.addSubview(nutritionDetail.text4)
        view.addSubview(nutritionDetail.text5)
        view.addSubview(nutritionDetail.text6)
        view.addSubview(nutritionDetail.button1)
        view.addSubview(nutritionDetail.button2)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Nutrition facts for \(nutrition.servingSize)g \(nutrition.name)"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constance.font, size: 22)!]
    }
}
