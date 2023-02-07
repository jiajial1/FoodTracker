//
//  SummaryViewController.swift
//  FoodTracker
//
//  Created by Jiajia Li on 1/30/23.
//

import UIKit
import Charts

class SummaryViewController: UIViewController {
    let calories: [Double] = [1800, 1600, 1800, 1600, 1800, 1800, 1800, 1600, 1800, 1600, 1800, 1800]

    private let tenDaysAvgLabel: UILabel = {
        let label = UILabel()
        label.text = "10-DAY-AVERAGE"
        label.font = UIFont(name: Constance.font, size: 18)
        label.textColor = .systemBlue
        return label
    }()
    
    private let tenDaysAvg: UILabel = {
        let label = UILabel()
        label.text = "1800"
        label.font = UIFont(name: Constance.font, size: 45)
        return label
    }()
    
    private let unit: UILabel = {
        let label = UILabel()
        label.text = "cal"
        label.font = UIFont(name: Constance.font, size: 18)
        return label
    }()
    
    private let tenDaysAvgView: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = Constance.cornerRadius
        return container
    }()
    
    private let barChart: BarChartView = {
        let chart = BarChartView()
        let dateStamp = ["1/20/2023", "1/20/2023", "1/20/2023", "1/20/2023","1/20/2023", "1/20/2023", "1/20/2023", "1/20/2023", "1/20/2023", "1/20/2023"]

        // Setup Y axis
        let leftAxis = chart.leftAxis
        leftAxis.setLabelCount(6, force: true)
        leftAxis.axisMinimum = 500.0

        let xAxis = chart.xAxis
        xAxis.labelRotationAngle = -25
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values: dateStamp)
        
        let rightAxis = chart.rightAxis
        rightAxis.enabled = false
        
        // Bar, Grid Line, Background
        chart.drawGridBackgroundEnabled = false
        chart.drawBordersEnabled = false
        chart.legend.enabled = false

        // disable zoom function
        chart.pinchZoomEnabled = false
        chart.setScaleEnabled(false)
        chart.doubleTapToZoomEnabled = false
        return chart
    }()
    
    private let barChartViewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = Constance.cornerRadius
        return container
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constance.beige
        configureNavigationBar()
        addSubViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frame
        tenDaysAvgView.frame = CGRect(x: 10,
                                      y: view.safeAreaInsets.top,
                                      width: view.width - 20,
                                      height: view.height / 4)
        configureTenDaysAvgView()
        
        barChartViewContainer.frame = CGRect(x: 10,
                                    y: tenDaysAvgView.bottom + 15,
                                    width: view.width - 20,
                                    height: view.height / 2)
        
        configureBarChart()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Summary"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constance.font, size: Constance.titleSize)!]
        navigationController?.title = "Summary"
    }
    
    private func configureBarChart() {
        barChart.frame = CGRect(x: 20,
                                y: (barChartViewContainer.height - view.height / 3)/2,
                                width: view.width - 50,
                                height: view.height / 3)
        
        setupBarChartData(barChart: barChart)
        barChartViewContainer.addSubview(barChart)
     }

    private func configureTenDaysAvgView() {
        // add tenDaysAvgLabel to the tenDaysAvgView
        tenDaysAvgView.addSubview(tenDaysAvgLabel)
        tenDaysAvgLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tenDaysAvgLabel.centerXAnchor.constraint(equalTo: tenDaysAvgView.centerXAnchor),
            tenDaysAvgLabel.centerYAnchor.constraint(equalTo: tenDaysAvgView.centerYAnchor, constant: -tenDaysAvgView.height/3.5)
        ])
        
        // add tenDaysAvg to the tenDaysAvgView
        tenDaysAvgView.addSubview(tenDaysAvg)
        tenDaysAvg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tenDaysAvg.centerXAnchor.constraint(equalTo: tenDaysAvgView.centerXAnchor, constant: -tenDaysAvgView.width/20),
            tenDaysAvg.centerYAnchor.constraint(equalTo: tenDaysAvgView.centerYAnchor)
        ])
        
        // add unit to the tenDaysAvgView
        tenDaysAvgView.addSubview(unit)
        unit.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unit.leftAnchor.constraint(equalTo: tenDaysAvg.rightAnchor, constant: tenDaysAvgView.width/25),
            unit.bottomAnchor.constraint(equalTo: tenDaysAvg.bottomAnchor, constant: -8)
        ])
    }
    
    private func addSubViews() {
        view.addSubview(tenDaysAvgView)
        view.addSubview(barChartViewContainer)
    }
}

