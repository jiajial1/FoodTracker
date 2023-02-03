//
//  Nutrition.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/1/23.
//

import Foundation

struct Nutrition: Codable, Equatable {
    let name: String
    let servingSize: Double
    let fatTotal: Double
    let calories: Double
    let protein: Double
    let carbohydratesTotal: Double
    let fiber: Double
//    let sugar: Double
//    let sodiumMg: Double
//    let potassiumMg: Double
//    let fatSaturated: Double
//    let cholesterolMg: Double

    enum CodingKeys: String, CodingKey {
        case name
        case servingSize = "serving_size_g"
        case fatTotal = "fat_total_g"
        case calories = "calories"
        case protein = "protein_g"
        case carbohydratesTotal = "carbohydrates_total_g"
        case fiber = "fiber_g"
//        case sugar = "sugar_g"
//        case sodiumMg = "sodium_mg"
//        case potassiumMg = "potassium_mg"
//        case fatSaturated = "fat_saturated_g"
//        case cholesterolMg = "cholesterol_mg"
   }
}

struct NutritionArray: Codable, Equatable {
    let items: [Nutrition]
}
