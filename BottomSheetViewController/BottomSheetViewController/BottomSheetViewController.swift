//
//  BottomSheetViewController.swift
//  BottomSheetViewController
//
//  Created by Орлов Максим on 14.10.2018.
//  Copyright © 2018 Орлов Максим. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    weak var delegate: BaseControllerDelegate?
    
    struct Constants {
        static let offset: CGFloat = 160
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
        view.addGestureRecognizer(gesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //MARK: Анимация при появлении
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            guard let unwrappedSelf = self else { return }
            let frame = unwrappedSelf.view.frame
            let yComponent = Constants.offset
            unwrappedSelf.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        })
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if (y + translation.y >= Constants.offset) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction], animations: { [weak self] in
                guard let unwrappedSelf = self else { return }
                print(velocity.y)
                unwrappedSelf.delegate?.hideBottomSheet()
                }, completion: nil )
        }
    }
}
