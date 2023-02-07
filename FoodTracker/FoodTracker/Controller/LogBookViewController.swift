//
//  LogBookViewController.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/1/23.
//

import Foundation
import UIKit

class LogBookViewController: UIViewController {
//    let cellWidth: Double = 45
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont(name: Constance.font, size: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let recordedLabel: UILabel = {
        let label = UILabel()
        label.text = "Recorded (cal)"
        label.textAlignment = .center
        label.font = UIFont(name: Constance.font, size: 20)
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.layer.cornerRadius = Constance.cornerRadius
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        let cellNib = UINib(nibName: "LogBookTableViewCell", bundle: nil)
        table.register(LogBookTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constance.beige
        configureNavigationBar()

        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safeAreaheight = view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
//        var heightOfTable = num * 45 > safeAreaheight ? safeAreaheight : num * 45
        tableView.frame = CGRect(x: 10,
                                 y: view.safeAreaInsets.top,
                                 width: view.width - 20,
                                 height: safeAreaheight)
    }

    private func configureNavigationBar() {
        navigationItem.title = "LogBook"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constance.font, size: Constance.titleSize)!]
        navigationController?.title = "LogBook"
    }
}

extension LogBookViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 45))
        header.backgroundColor = Constance.beige
        
        let textLabelWidth = (view.width - 20) / 2
        dateLabel.frame = CGRect(x: 0, y: 0, width: textLabelWidth-20, height: 45)
        recordedLabel.frame = CGRect(x: textLabelWidth, y: 0, width: textLabelWidth, height: 45)
        
        header.addSubview(dateLabel)
        header.addSubview(recordedLabel)

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LogBookTableViewCell
        cell.textLabel1.text =  "2023/02/03"
        cell.textLabel2.text = "1800.00"
//        cell?.textLabel1!.text = "falfjaljf: \(indexPath.section) | row: \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

//    private let proteinLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Protein (gram)"
//        label.font = UIFont(name: Constance.font, size: 20)
//        return label
//    }()
//
//    private let carbohydratesLable: UILabel = {
//        let label = UILabel()
//        label.text = "Carbohydrates (gram)"
//        label.font = UIFont(name: Constance.font, size: 20)
//        return label
//    }()
//
//    private let fatLable: UILabel = {
//        let label = UILabel()
//        label.text = "Fat (gram)"
//        label.font = UIFont(name: Constance.font, size: 20)
//        return label
//    }()
//
//    private let fiberLable: UILabel = {
//        let label = UILabel()
//        label.text = "Fiber (gram)"
//        label.font = UIFont(name: Constance.font, size: 20)
//        return label
//    }()
