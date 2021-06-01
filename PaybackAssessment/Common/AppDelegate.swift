//
//  AppDelegate.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/1/21.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var networkManager = NetworkManagerFactory().createNetworkManager()
    lazy var networkStateNotifier = NetworkStateNotifier()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PaybackAssessment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        })
        return container
    }()
//    lazy var webSocketManager: WebSocketManager = WebSocketManager(userManager: userManager)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let frame = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
//        self.window?.rootViewController = setHomeViewcontroller()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

// ===============
// MARK: - Methods
// ===============
extension AppDelegate {
    class func getInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
//    func setHomeViewcontroller() -> UIViewController {
//        let dc = HomeDependencyContainer()
//        let homeVC = dc.makeHomeViewController()
//        let navVc = CustomNavigationController(rootViewController: homeVC)
//        return navVc
//    }
}

