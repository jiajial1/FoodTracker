//
//  LogBookTableViewCell.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/3/23.
//

import Foundation
import UIKit

class LogBookTableViewCell: UITableViewCell {
    var textLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constance.font, size: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var textLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constance.font, size: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let width = contentView.width / 2
        textLabel1.frame = CGRect(x: 0, y: 0, width: width, height: 45)
        textLabel2.frame = CGRect(x: width, y: 0, width: 200, height: 45)
        
        contentView.addSubview(textLabel1)
        contentView.addSubview(textLabel2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
