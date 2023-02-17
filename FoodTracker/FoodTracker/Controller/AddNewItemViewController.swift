//
//  AddNewItemViewController.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/1/23.
//

import Foundation
import UIKit
import CoreData

class AddNewItemViewController: UIViewController {
    var currentSearchTask: URLSessionDataTask?
    var dataController: DataController!
    var addNewItemView = AddNewItemView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constance.beige
                
        configureNavigationBar()
        configureSpinner()
        addNewItemView.searchBar.delegate = self
        view.addSubview(addNewItemView.searchBar)
        
        addNewItemView.tableView.delegate = self
        addNewItemView.tableView.dataSource = self
        view.addSubview(addNewItemView.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNewItemView.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frame
        configureSearchBar()
        configureSpinner()
        
        addNewItemView.tableView.frame = CGRect(x: 10,
                                                y: addNewItemView.searchBar.bottom + 10,
                                                width: view.width - 20,
                                                height: view.height)
    }
    
    private func configureSpinner() {
        view.addSubview(addNewItemView.spinner)
        addNewItemView.spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addNewItemView.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addNewItemView.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Utils.getFormatedDate(date: Date())
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constance.font, size: Constance.titleSize)!]
    }
    

    private func configureSearchBar() {
        addNewItemView.searchBar.frame = CGRect(x: 20,
                                                y: view.safeAreaInsets.top + 10,
                                                width: view.width - 40,
                                                height: 40)
        
        addNewItemView.searchBar.placeholder = "Search food with wt., eg. 1 oz apple"
        addNewItemView.searchBar.searchTextField.font = UIFont(name: "GillSans", size: 18)
        addNewItemView.searchBar.searchTextField.backgroundColor = UIColor.white
    }
    
}

extension AddNewItemViewController: UISearchBarDelegate {
    func searchResultsHandler( results: [Nutrition], error: Error?) {
       addNewItemView.spinner.stopAnimating()
        
        guard results != [] else {
            let alertVC = UIAlertController(title: "No item found", message: "Please try another food item", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true)
            addNewItemView.searchBar.text = ""
            return
        }
        
        presentModal(nutrition: results[0])
    }
    
    private func presentModal(nutrition: Nutrition) {
        let detailViewController = NutritionDetailViewController()
        detailViewController.nutrition = nutrition
        detailViewController.dataController = dataController
        detailViewController.delegate = self

        let nav = UINavigationController(rootViewController: detailViewController)
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(nav, animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        addNewItemView.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        currentSearchTask?.cancel()
        addNewItemView.spinner.startAnimating()
        currentSearchTask = FoodClient.getNutrition(query: searchBar.text ?? "", completion: searchResultsHandler(results:error:))
        searchBar.text = ""
    }
}

extension AddNewItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 45))
        header.backgroundColor = Constance.beige
        
        let textLabelWidth = (view.width - 20) / 2
        addNewItemView.foodColoumLabel.frame = CGRect(x: 0, y: 0, width: textLabelWidth-20, height: 45)
        addNewItemView.calColoumLabel.frame = CGRect(x: textLabelWidth, y: 0, width: textLabelWidth, height: 45)
        
        header.addSubview(addNewItemView.foodColoumLabel)
        header.addSubview(addNewItemView.calColoumLabel)
        
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
        if let foodList = UserDefaults.standard.array(forKey: "foodItems") as? [String], let calories = UserDefaults.standard.array(forKey: "calories") as? [Double]{
            cell.textLabel1.text = foodList[indexPath.row]
            cell.textLabel2.text = String(calories[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaults.standard.array(forKey: "foodItems")?.count ?? 0
    }
}

extension AddNewItemViewController: NutritionDetailViewControllerDelegate {
    func didTapOnButton() {
        addNewItemView.tableView.reloadData()
    }
}
