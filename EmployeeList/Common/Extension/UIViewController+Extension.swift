//
//  UIViewController+Extension.swift
//  EmployeeList
//
//  Created by PT Phincon on 29/07/23.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    func showError(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavigation(title: String = "") {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemOrange
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor =  UIColor.init(red: 103/255, green: 103/255, blue: 103/255, alpha: 1.0)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.backItem?.title = "Custom"
        navigationItem.backButtonTitle = "custom"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Return", style: .plain, target: nil, action: nil)
    }
}
