//
//  TabBarController.swift
//  MyHabits
//
//  Created by Николай Гринько on 15.03.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(named: "dPurple")
        setupVC()
       
    }
   func setupVC() {
        viewControllers = [
            createNavigationController(rootVC: HabitListViewController(), title: "Привычки", image: UIImage(named: "TabBarLeftIcon")!),
            createNavigationController(rootVC: InfoViewController(), title: "Информация", image: UIImage(systemName: "info.circle.fill")!)
        ]
    }
   func createNavigationController(rootVC: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootVC)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
