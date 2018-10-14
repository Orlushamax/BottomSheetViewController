//
//  ViewController.swift
//  BaseControllerViewController
//
//  Created by Орлов Максим on 14.10.2018.
//  Copyright © 2018 Орлов Максим. All rights reserved.
//

import UIKit

protocol BaseControllerDelegate: class {
    func hideBottomSheet()
}

class BaseController: UIViewController {

    @IBOutlet weak var showButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showButton.layer.cornerRadius = self.showButton.frame.height / 2
        showButton.clipsToBounds = true
        
    }
    
    private lazy var bottomViewController: BottomSheetViewController = {
        var viewController = BottomSheetViewController(nibName: String(describing: BottomSheetViewController.self), bundle: nil)
        viewController.delegate = self
        return viewController
    }()
    
    @IBAction func showChild(sender: UIButton) {
        addBottomSheetView(asChildViewController: bottomViewController)
    }
}

extension BaseController: BaseControllerDelegate {
    func hideBottomSheet() {
        if let buttonController = self.childViewControllers.last as? BottomSheetViewController {
            UIView.animate(withDuration: 0.4, animations: { [weak self] in
                guard let unwrappedSelf = self else { return }
                let height = unwrappedSelf.view.frame.height
                let width  = unwrappedSelf.view.frame.width
                buttonController.view.frame = CGRect(x: 0,y: unwrappedSelf.view.frame.maxY, width: width,height: height)
                }, completion: { [weak self] finished in
                    guard let unwrappedSelf = self else { return }
                    unwrappedSelf.remove(asChildViewController: buttonController)
            })
        }
    }
}
