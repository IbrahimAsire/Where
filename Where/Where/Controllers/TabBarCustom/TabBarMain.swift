
import Foundation
import UIKit

class TabBarMain: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            barItem(tabBarTitle: "Cafes".Localizable(), tabBarImage: UIImage(systemName: "cup.and.saucer.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: CafesVC()),
            
            barItem(tabBarTitle: "New Places".Localizable(), tabBarImage: UIImage(systemName: "house")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: NewPlacesVC()),
            
            barItem(tabBarTitle: "Photo Store".Localizable(), tabBarImage: UIImage(systemName: "photo.artframe")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: PhotoStoreVC()),
            
            barItem(tabBarTitle: "Exit".Localizable(), tabBarImage: UIImage(systemName: "pip.exit")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: ExitVC()),
            
            barItem(tabBarTitle: "News".Localizable(), tabBarImage: UIImage(systemName: "newspaper")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: News()),
            
            barItem(tabBarTitle: "Add a place".Localizable(), tabBarImage: UIImage(systemName: "plus.message.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: AddNewPlace()),
            
            barItem(tabBarTitle: "Add a test".Localizable(), tabBarImage: UIImage(systemName: "plus.message.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: One()),
            
            barItem(tabBarTitle: "Shoe test a place".Localizable(), tabBarImage: UIImage(systemName: "plus.message.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: Three()),

        ]
        
        tabBar.backgroundColor = .systemBrown
        tabBar.isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        tabBar.unselectedItemTintColor = UIColor(#colorLiteral(red: 0.2403967083, green: 0.1442204118, blue: 0.02279633656, alpha: 1))
        selectedIndex = 0
        selectedIndex = 0
    }
    
    private func barItem(tabBarTitle: String, tabBarImage: UIImage, viewController: UIViewController) -> UINavigationController {
        let navCont = UINavigationController(rootViewController: viewController)
        navCont.tabBarItem.title = tabBarTitle
        navCont.tabBarItem.image = tabBarImage
        return navCont
    }
    
}
