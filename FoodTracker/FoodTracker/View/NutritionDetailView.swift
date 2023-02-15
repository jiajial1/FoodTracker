//
//  NutritionDetailView.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/7/23.
//

import Foundation
import UIKit

class NutritionDetailView: UIView {
    lazy var text1 = createUILable()
    lazy var text2 = createUILable()
    lazy var text3 = createUILable()
    lazy var text4 = createUILable()
    lazy var text5 = createUILable()
    lazy var text6 = createUILable()
    lazy var button1 = createButton(buttonTitle: "YES")
    lazy var button2 = createButton(buttonTitle: "NO")

    private func createButton(buttonTitle: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGray4
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Constance.font, size: 15)
        button.layer.cornerRadius = 5.0
        return button
    }
    
    private func createUILable() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Constance.font, size: 18)
        label.adjustsFontSizeToFitWidth = true

        return label
    }
}
