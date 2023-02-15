//
//  SummaryView.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/7/23.
//

import Foundation
import UIKit
import Charts

class SummaryView: UIView {
    lazy var tenDaysAvgLabel: UILabel = {
        let label = UILabel()
        label.text = "10-DAY-AVERAGE"
        label.font = UIFont(name: Constance.font, size: 18)
        label.textColor = .systemBlue
        return label
    }()
    
    lazy var tenDaysAvg: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constance.font, size: 45)
        return label
    }()
    
    lazy var unit: UILabel = {
        let label = UILabel()
        label.text = "cal"
        label.font = UIFont(name: Constance.font, size: 18)
        return label
    }()
    
    lazy var tenDaysAvgView: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = Constance.cornerRadius
        return container
    }()
    
    lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data"
        label.font = UIFont(name: Constance.font, size: 40)
        label.textColor = .systemBlue
        return label
    }()
    
    lazy var barChart: BarChartView = {
        let chart = BarChartView()

        // Setup Y axis
        let leftAxis = chart.leftAxis
        leftAxis.setLabelCount(6, force: true)
        leftAxis.axisMinimum = 0.0

        let xAxis = chart.xAxis
        xAxis.labelRotationAngle = -25
        xAxis.labelPosition = .bottom

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
    
    lazy var barChartViewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = Constance.cornerRadius
        return container
    }()
}
