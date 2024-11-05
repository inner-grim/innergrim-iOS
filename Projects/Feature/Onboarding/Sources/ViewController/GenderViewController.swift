//
//  GenderViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/6/24.
//

import Combine
import UIKit

import Shared

public protocol GenderViewControllerDelegate: AnyObject {
    func genderViewControllerDidFinish()
}

public final class GenderViewController: BaseViewController<GenderView> {
    public weak var delegate: GenderViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    private let genderTypes = GenderType.allCases
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden()
        setupGenderCollectionView()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupGenderCollectionView() {
        genderCollectionView.delegate = self
        genderCollectionView.dataSource = self
    }
    
    private func setupBindings() {
        startButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.genderViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

extension GenderViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing = 8
        let itemCount = genderTypes.count
        let width = (Int(collectionView.frame.width) - spacing * (itemCount - 1)) / itemCount
        return CGSize(width: width, height: 62)
    }
}

extension GenderViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return genderTypes.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GenderCell.self)
        cell.configure(with: genderTypes[indexPath.row])
        return cell
    }
}

private extension GenderViewController {
    var genderCollectionView: UICollectionView {
        contentView.collectionView
    }
    
    var startButton: SolidButton {
        contentView.startButton
    }
}
