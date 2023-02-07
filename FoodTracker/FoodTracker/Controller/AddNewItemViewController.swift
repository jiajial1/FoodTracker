//
//  AddNewItemViewController.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/1/23.
//

import Foundation
import UIKit

class AddNewItemViewController: UIViewController {
    var currentSearchTask: URLSessionDataTask?
//    var nutritionArray = [Nutrition]()

//    var nutritionArray = [FoodTracker.Nutrition(name: "beef", servingSize: 28.3495, fatTotal: 5.6, calories: 82.8, protein: 7.5, carbohydratesTotal: 0.0, fiber: 0.0), FoodTracker.Nutrition(name: "apple", servingSize: 28.3495, fatTotal: 0.0, calories: 15.0, protein: 0.1, carbohydratesTotal: 4.0, fiber: 0.7), FoodTracker.Nutrition(name: "banana", servingSize: 28.3495, fatTotal: 0.1, calories: 25.3, protein: 0.3, carbohydratesTotal: 6.6, fiber: 0.7)]
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.layer.cornerRadius = Constance.cornerRadius
        table.register(LogBookTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let foodColoumLabel: UILabel = {
        let label = UILabel()
        label.text = "Food item"
        label.font = UIFont(name: Constance.font, size: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let calColoumLabel: UILabel = {
        let label = UILabel()
        label.text = "Calories"
        label.textAlignment = .center
        label.font = UIFont(name: Constance.font, size: 20)
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constance.beige
        
        configureNavigationBar()
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reload")
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    private func configureNavigationBar() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        navigationItem.title = dateFormatter.string(from: Date())
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constance.font, size: Constance.titleSize)!]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frame
        configureSearchBar()
        tableView.frame = CGRect(x: 10,
                                 y: searchBar.bottom + 10,
                                 width: view.width - 20,
                                 height: 200)

//                                 height: Constance.cellHeight * CGFloat(nutritionArray.count+1))
    }
    
    private func configureSearchBar() {
        searchBar.frame = CGRect(x: 20,
                                      y: view.safeAreaInsets.top + 10,
                                      width: view.width - 40,
                                      height: 40)

        searchBar.placeholder = "Search food with wt., eg. 1 oz apple"
        searchBar.searchTextField.font = UIFont(name: "GillSans", size: 18)
        searchBar.searchTextField.backgroundColor = UIColor.white
    }
    
    func showSearchResult(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: nil))
        alertVC.addAction(UIAlertAction(title: "ADD TO LIST", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}

extension AddNewItemViewController: UISearchBarDelegate {
    func searchResultsHandler( results: [Nutrition], error: Error?) {
        guard results != [] else {
            let alertVC = UIAlertController(title: "No item found", message: "Please try another food item", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true)
            searchBar.text = ""
            return
        }
        
        presentModal(nutrition: results[0])
    }

    private func presentModal(nutrition: Nutrition) {
        let detailViewController = NutritionDetailViewController()
        detailViewController.nutrition = nutrition
//        let nav = UINavigationController(rootViewController: detailViewController)
//        nav.modalPresentationStyle = .pageSheet
//
//        if let sheet = nav.sheetPresentationController {
//            sheet.detents = [.medium()]
//        }
//        present(nav, animated: true, completion: nil)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = true
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = false
//    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        currentSearchTask?.cancel()
        currentSearchTask = FoodClient.getNutrition(query: searchBar.text ?? "", completion: searchResultsHandler(results:error:))
        searchBar.text = ""
    }
}

extension AddNewItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 45))
        header.backgroundColor = Constance.beige
        
        let textLabelWidth = (view.width - 20) / 2
        foodColoumLabel.frame = CGRect(x: 0, y: 0, width: textLabelWidth-20, height: 45)
        calColoumLabel.frame = CGRect(x: textLabelWidth, y: 0, width: textLabelWidth, height: 45)
        
        header.addSubview(foodColoumLabel)
        header.addSubview(calColoumLabel)

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constance.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LogBookTableViewCell
        if let nutritionArray = UserDefaults.standard.array(forKey: "nutrition") as? [Nutrition] {
            cell.textLabel1.text = nutritionArray[indexPath.row].name
            cell.textLabel2.text = String(nutritionArray[indexPath.row].calories)
        }

//        cell.textLabel1.text = nutritionArray[indexPath.row].name
//        cell.textLabel2.text = String(nutritionArray[indexPath.row].calories)
//        cell.textLabel1.text = UserDefaults.standard.array(forKey: "foodItems") as? String
//        cell.textLabel2.text = UserDefaults.standard.array(forKey: "calories") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaults.standard.array(forKey: "foodItems")?.count ?? 0
    }
}
