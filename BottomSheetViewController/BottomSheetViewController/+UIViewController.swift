//
//  +UIViewController.swift
//  BottomSheetViewController
//
//  Created by Орлов Максим on 14.10.2018.
//  Copyright © 2018 Орлов Максим. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    func addBottomSheetView(asChildViewController viewController: UIViewController) {
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        viewController.view.frame = CGRect(x: 0,y: self.view.frame.maxY,width: width,height: height)
    }
}
