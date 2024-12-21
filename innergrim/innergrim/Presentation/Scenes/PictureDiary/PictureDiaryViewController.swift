//
//  PictureDiaryViewController.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import UIKit

final class PictureDiaryViewController: BaseViewController<PictureDiaryView> {
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "그림일기") // TODO: 타이틀 변경
    }
}
