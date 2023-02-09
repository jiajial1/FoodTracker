//
//  SummaryViewController.swift
//  FoodTracker
//
//  Created by Jiajia Li on 1/30/23.
//

import UIKit
import Charts
import CoreData

class SummaryViewController: UIViewController, NSFetchedResultsControllerDelegate {
    var dataController: DataController!
    var fetchedResultsController:NSFetchedResultsController<LogItem>!
    let summaryView = SummaryView()
    
    let calories: [Double] = [1800, 1600, 1800, 1600, 1800, 1800, 1800, 1600, 1800, 1600, 1800, 1800]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFetchedResutlController()
        view.backgroundColor = Constance.beige
        configureNavigationBar()
        addSubViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frame
        summaryView.tenDaysAvgView.frame = CGRect(x: 10,
                                                  y: view.safeAreaInsets.top,
                                                  width: view.width - 20,
                                                  height: view.height / 4)
        configureTenDaysAvgView()
        
        summaryView.barChartViewContainer.frame = CGRect(x: 10,
                                                         y: summaryView.tenDaysAvgView.bottom + 15,
                                                         width: view.width - 20,
                                                         height: view.height / 2)
        
        configureBarChart()
    }
    
    func configureFetchedResutlController() {
        let fetchRequest: NSFetchRequest<LogItem> = LogItem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var dateFormated = Utils.getFormatedDate(date: Date())
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "\(dateFormated)")
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    private func setupBarChartData(barChart: BarChartView) {
        var entries = [BarChartDataEntry]()
        for x in 0..<10 {
            entries.append(
                BarChartDataEntry(
                    x: Double(x),
                    y: calories[x]
                )
            )
        }
        let set = BarChartDataSet(entries: entries, label: "Calories")
        // set.colors = [NSUIColor(ciColor: CIColor(color: .systemOrange))]
        set.colors = ChartColorTemplates.joyful()
        let data =  BarChartData(dataSet: set)
        barChart.data = data
    }
    
    
    private func configureNavigationBar() {
        navigationItem.title = "Summary"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constance.font, size: Constance.titleSize)!]
        navigationController?.title = "Summary"
    }
    
    private func configureBarChart() {
        summaryView.barChart.frame = CGRect(x: 20,
                                            y: (summaryView.barChartViewContainer.height - view.height / 3)/2,
                                            width: view.width - 50,
                                            height: view.height / 3)
        
        setupBarChartData(barChart: summaryView.barChart)
        summaryView.barChartViewContainer.addSubview(summaryView.barChart)
    }
    
    private func configureTenDaysAvgView() {
        // add tenDaysAvgLabel to the tenDaysAvgView
        summaryView.tenDaysAvgView.addSubview(summaryView.tenDaysAvgLabel)
        summaryView.tenDaysAvgLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryView.tenDaysAvgLabel.centerXAnchor.constraint(equalTo: summaryView.tenDaysAvgView.centerXAnchor),
            summaryView.tenDaysAvgLabel.centerYAnchor.constraint(equalTo: summaryView.tenDaysAvgView.centerYAnchor, constant: -summaryView.tenDaysAvgView.height/3.5)
        ])
        
        // add tenDaysAvg to the tenDaysAvgView
        summaryView.tenDaysAvgView.addSubview(summaryView.tenDaysAvg)
        summaryView.tenDaysAvg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryView.tenDaysAvg.centerXAnchor.constraint(equalTo: summaryView.tenDaysAvgView.centerXAnchor, constant: -summaryView.tenDaysAvgView.width/20),
            summaryView.tenDaysAvg.centerYAnchor.constraint(equalTo: summaryView.tenDaysAvgView.centerYAnchor)
        ])
        
        // add unit to the tenDaysAvgView
        summaryView.tenDaysAvgView.addSubview(summaryView.unit)
        summaryView.unit.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryView.unit.leftAnchor.constraint(equalTo: summaryView.tenDaysAvg.rightAnchor, constant: summaryView.tenDaysAvgView.width/25),
            summaryView.unit.bottomAnchor.constraint(equalTo: summaryView.tenDaysAvg.bottomAnchor, constant: -8)
        ])
    }
    
    private func addSubViews() {
        view.addSubview(summaryView.tenDaysAvgView)
        view.addSubview(summaryView.barChartViewContainer)
    }
}

