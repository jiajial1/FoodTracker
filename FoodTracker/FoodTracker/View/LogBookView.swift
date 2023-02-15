//
//  LogBookView.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/7/23.
//

import Foundation
import UIKit

class LogBookView: UIView {
    //    let cellWidth: Double = 45
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont(name: Constance.font, size: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var  recordedLabel: UILabel = {
        let label = UILabel()
        label.text = "Recorded (cal)"
        label.textAlignment = .center
        label.font = UIFont(name: Constance.font, size: 20)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var  tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.layer.cornerRadius = Constance.cornerRadius
        table.backgroundColor = Constance.beige
        //        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //        let cellNib = UINib(nibName: "LogBookTableViewCell", bundle: nil)
        table.register(LogBookTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
}
