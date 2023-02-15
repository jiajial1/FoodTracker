//
//  AddNewItemView.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/7/23.
//

import Foundation
import UIKit

class AddNewItemView: UIView {
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = Constance.beige
        table.layer.cornerRadius = Constance.cornerRadius
        table.register(LogBookTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    lazy var foodColoumLabel: UILabel = {
        let label = UILabel()
        label.text = "Food item"
        label.font = UIFont(name: Constance.font, size: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var calColoumLabel: UILabel = {
        let label = UILabel()
        label.text = "Calories"
        label.textAlignment = .center
        label.font = UIFont(name: Constance.font, size: 20)
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
}
