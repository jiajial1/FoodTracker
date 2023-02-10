//
//  LogBookViewController.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/1/23.
//

import Foundation
import UIKit
import CoreData

class LogBookViewController: UIViewController,  NSFetchedResultsControllerDelegate {
    var logBook = LogBookView()
    var dataController: DataController!
    var fetchedResultsController:NSFetchedResultsController<LogItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFetchedResutlController()
        
        view.backgroundColor = Constance.beige
        configureNavigationBar()
        
        view.addSubview(logBook.tableView)
        logBook.tableView.dataSource = self
        logBook.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureFetchedResutlController()
        logBook.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logBook.tableView.frame = CGRect(x: 10,
                                         y: view.safeAreaInsets.top,
                                         width: view.width - 20,
                                         height: view.height)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "LogBook"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constance.font, size: Constance.titleSize)!]
        navigationController?.title = "LogBook"
    }
    
    func configureFetchedResutlController() {
        let fetchRequest: NSFetchRequest<LogItem> = LogItem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Only search current day's data
        var dateFormated = Utils.getFormatedDate(date: Date())
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "\(dateFormated)")
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
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
        return Constance.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LogBookTableViewCell
        let logItem = fetchedResultsController.object(at: indexPath)
        
        if let date = logItem.date {
            cell.textLabel1.text = date
            cell.textLabel2.text = String(logItem.calories)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
}
