//
//  SceneDelegate.swift
//  FoodTracker
//
//  Created by Jiajia Li on 1/30/23.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate, NSFetchedResultsControllerDelegate {

    var window: UIWindow?

    let dataController = DataController(modelName: "FoodTracker")
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let _ = (scene as? UIWindowScene) else { return }

        // Save user's current menu in the UserDefaults
        if !isSameDay() {
            emptyFoodList()
        }
        
        dataController.load()
        
        if let tabBarVC = window?.rootViewController as? UITabBarController, let navVC = tabBarVC.viewControllers![0] as? UINavigationController, let VC = navVC.topViewController as? SummaryViewController{
            VC.dataController = dataController
        }
        
        if let tabBarVC = window?.rootViewController as? UITabBarController, let navVC = tabBarVC.viewControllers![1] as? UINavigationController, let VC = navVC.topViewController as? AddNewItemViewController{
            VC.dataController = dataController
        }
        
        if let tabBarVC = window?.rootViewController as? UITabBarController, let navVC = tabBarVC.viewControllers![2] as? UINavigationController, let VC = navVC.topViewController as? LogBookViewController{
            VC.dataController = dataController
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        if !isSameDay() {
            print("sceneWillEnterForeground")
            emptyFoodList()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    func isSameDay() -> Bool {
        if let dateOnFile = UserDefaults.standard.object(forKey: "dateOnFile") as? NSDate{
            let diff = Calendar.current.dateComponents([.day], from: NSDate() as Date, to: dateOnFile as Date)
            return diff.day == 0
        } else {
            UserDefaults.standard.set(NSDate(), forKey: "dateOnFile")
        }
        return false
    }
    
    func emptyFoodList() {
        let foodItemsArray: [String] = []
        let caloriesArray: [Double] = []
        UserDefaults.standard.set(foodItemsArray, forKey: "foodItems")
        UserDefaults.standard.set(caloriesArray, forKey: "calories")
    }
}

