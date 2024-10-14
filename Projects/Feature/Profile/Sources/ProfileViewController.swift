//
//  ProfileViewController.swift
//  FeatureProfile
//
//  Created by 지연 on 10/15/24.
//

import UIKit

public final class ProfileViewController: UIViewController {
    // MARK: - Life Cycle
    
    public override func loadView() {
        view = ProfileView()
    }
}
