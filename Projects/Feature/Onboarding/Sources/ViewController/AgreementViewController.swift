//
//  AgreementViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/6/24.
//

import UIKit

import Shared

public final class AgreementViewController: BaseViewController<AgreementView> {
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(isDismissButtonHidden: true, title: "약관 동의")
    }
}
