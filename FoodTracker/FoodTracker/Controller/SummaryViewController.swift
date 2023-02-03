//
//  SummaryViewController.swift
//  FoodTracker
//
//  Created by Jiajia Li on 1/30/23.
//

import UIKit

class SummaryViewController: UIViewController {
    struct Constance {
        static let cornerRadius: CGFloat = 8.0
        static let font: String = "GillSans"
        
    }
    let dataStamp = [Date(), Date(),Date(),Date(),Date(),Date()]
    let calories = [1800, 1600, 1800, 1600, 1800, 1800]

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
    
    private let barChartView: UIView = {
        let container = UIView()
//        container.backgroundColor = .systemBackground
        container.backgroundColor = .red

        container.layer.cornerRadius = Constance.cornerRadius
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        
        // beige
        view.backgroundColor = UIColor(red: 250/255, green: 242/255, blue: 223/255, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frame
        tenDaysAvgView.frame = CGRect(x: 10,
                                      y: view.safeAreaInsets.top,
                                      width: view.width - 20,
                                      height: view.height / 4)
        configureTenDaysAvgView()
        
        barChartView.frame = CGRect(x: 10,
                                    y: tenDaysAvgView.bottom + 15,
                                    width: view.width - 20,
                                    height: view.height / 2)
    }
    
    private func configureTenDaysAvgView() {
        // add tenDaysAvgLabel to the tenDaysAvgView
        tenDaysAvgView.addSubview(tenDaysAvgLabel)
        tenDaysAvgLabel.translatesAutoresizingMaskIntoConstraints = false
        tenDaysAvgLabel.centerXAnchor.constraint(equalTo: tenDaysAvgView.centerXAnchor).isActive = true
        tenDaysAvgLabel.centerYAnchor.constraint(equalTo: tenDaysAvgView.centerYAnchor, constant: -tenDaysAvgView.height/3.5).isActive = true
        
        // add tenDaysAvg to the tenDaysAvgView
        tenDaysAvgView.addSubview(tenDaysAvg)
        tenDaysAvg.translatesAutoresizingMaskIntoConstraints = false
        tenDaysAvg.centerXAnchor.constraint(equalTo: tenDaysAvgView.centerXAnchor, constant: -tenDaysAvgView.width/20).isActive = true
        tenDaysAvg.centerYAnchor.constraint(equalTo: tenDaysAvgView.centerYAnchor).isActive = true
        
        // add unit to the tenDaysAvgView
        tenDaysAvgView.addSubview(unit)
        unit.translatesAutoresizingMaskIntoConstraints = false
        unit.leftAnchor.constraint(equalTo: tenDaysAvg.rightAnchor, constant: tenDaysAvgView.width/25).isActive = true
        unit.bottomAnchor.constraint(equalTo: tenDaysAvg.bottomAnchor, constant: -8).isActive = true
    }
    
    private func addSubViews() {
        view.addSubview(tenDaysAvgView)
        view.addSubview(barChartView)
    }

}

