//
//  HomeViewController.swift
//  FeatureHome
//
//  Created by 지연 on 10/10/24.
//

import UIKit

public final class HomeViewController: UIViewController {
    // MARK: - Life Cycle
    
    public override func loadView() {
        view = HomeView()
    }
}
