//
//  NutritionResponse.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/1/23.
//

import Foundation

struct NutritionResponse: Codable, Equatable {
    let items: [Nutrition]
}
