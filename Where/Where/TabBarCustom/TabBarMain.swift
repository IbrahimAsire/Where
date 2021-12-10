//
//  TabBar.swift
//  Where
//
//  Created by ibrahim asiri on 20/04/1443 AH.
//

import Foundation
import UIKit


class TabBarMain: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            barItem(tabBarTitle: "cafes", tabBarImage: UIImage(systemName: "cup.and.saucer.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: CafesVC()),
            
            barItem(tabBarTitle: "Map", tabBarImage: UIImage(systemName: "map.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: MapVC()),
            
            barItem(tabBarTitle: "New Places", tabBarImage: UIImage(systemName: "newspaper")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: PlacesVC()),
            
            barItem(tabBarTitle: "Exit", tabBarImage: UIImage(systemName: "pip.exit")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: ExitVC()),
            
            barItem(tabBarTitle: "CountryInfo", tabBarImage: UIImage(systemName: "homekit")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: CountryInfo()),

        ]
        
        tabBar.backgroundColor = .systemBrown
        tabBar.isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        tabBar.unselectedItemTintColor = .white
        selectedIndex = 0
    }
    
    private func barItem(tabBarTitle: String, tabBarImage: UIImage, viewController: UIViewController) -> UINavigationController {
        let navCont = UINavigationController(rootViewController: viewController)
        navCont.tabBarItem.title = tabBarTitle
        navCont.tabBarItem.image = tabBarImage
        return navCont
    }
    
}
