//
//  LogBookViewController.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/1/23.
//

import Foundation
import UIKit

class LogBookViewController: UIViewController {
    var logBook = LogBookView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constance.beige
        configureNavigationBar()
        
        view.addSubview(logBook.tableView)
        logBook.tableView.dataSource = self
        logBook.tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safeAreaheight = view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
        //        var heightOfTable = num * 45 > safeAreaheight ? safeAreaheight : num * 45
        logBook.tableView.frame = CGRect(x: 10,
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
        logBook.dateLabel.frame = CGRect(x: 0, y: 0, width: textLabelWidth-20, height: 45)
        logBook.recordedLabel.frame = CGRect(x: textLabelWidth, y: 0, width: textLabelWidth, height: 45)
        
        header.addSubview(logBook.dateLabel)
        header.addSubview(logBook.recordedLabel)
        
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
