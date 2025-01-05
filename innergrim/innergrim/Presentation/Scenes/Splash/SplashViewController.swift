//
//  SplashViewController.swift
//  innergrim
//
//  Created by 지연 on 1/5/25.
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func splashDidFinish()
}

final class SplashViewController: BaseViewController<SplashView> {
    weak var delegate: SplashViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundColor(with: .primaryNormal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.delegate?.splashDidFinish()
        }
    }
}
