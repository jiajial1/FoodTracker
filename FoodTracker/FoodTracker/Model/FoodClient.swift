//
//  FoodClient.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/1/23.
//

import Foundation

class FoodClient {
    static let apiKey = "6uMmKgtvV1NgLntkXzmXgg==KBhbFPX00RhTA8RR"
    
    enum Endpoints {
        static let base = "https://api.calorieninjas.com/v1"
        
        case getNutrition(String)
        
        var stringValue: String {
            switch self {
            case .getNutrition(let query): return Endpoints.base + "/nutrition?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getNutrition(query: String, completion: @escaping ([Nutrition], Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: Endpoints.getNutrition(query).url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion([], error)
                }
            return
            }

            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(NutritionArray.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject.items, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([], error)
                }
            }
        }
        task.resume()
        return task
    }
}
