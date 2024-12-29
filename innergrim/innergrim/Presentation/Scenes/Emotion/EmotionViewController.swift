//
//  EmotionViewController.swift
//  innergrim
//
//  Created by 지연 on 12/29/24.
//

import Combine
import UIKit

final class EmotionViewController: BaseViewController<EmotionView> {
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<EmotionSectionViewModel, EmotionCellViewModel>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(backImage: .arrowLeft)
        setupEmotionCollectionView()
        setupBindings()
        
        // 임시
        let sectionViewModels: [EmotionSectionViewModel] = [
            EmotionSectionViewModel(
                category: Emotion.Category.positive,
                cellViewModels: Emotion.allCases.filter { $0.category == .positive }.map {
                    EmotionCellViewModel(emotion: $0)
                }
            ),
            EmotionSectionViewModel(
                category: Emotion.Category.negative,
                cellViewModels: Emotion.allCases.filter { $0.category == .negative }.map {
                    EmotionCellViewModel(emotion: $0)
                }
            ),
            EmotionSectionViewModel(
                category: Emotion.Category.neutral,
                cellViewModels: Emotion.allCases.filter { $0.category == .neutral }.map {
                    EmotionCellViewModel(emotion: $0)
                }
            )
        ]
        applySnapshot(with: sectionViewModels)
    }
    
    // MARK: - Setup Methods
    
    private func setupEmotionCollectionView() {
        emotionCollectionView.delegate = self
        // cell
        dataSource = .init(
            collectionView: emotionCollectionView,
            cellProvider: { collectionView, indexPath, viewModel in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: EmotionCell.self
                )
                cell.configure(with: viewModel)
                return cell
            })
        // header
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }
            let headerView = collectionView.dequeueReusableHeader(
                for: indexPath,
                viewType: EmotionHeader.self
            )
            let sectionViewModel = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            headerView.configure(with: sectionViewModel)
            return headerView
        }
    }
    
    private func setupBindings() {
        // action
        backButton.tapPublisher
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with sectionViewModels: [EmotionSectionViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<EmotionSectionViewModel, EmotionCellViewModel>()
        
        sectionViewModels.forEach { sectionViewModel in
            snapshot.appendSections([sectionViewModel])
            snapshot.appendItems(sectionViewModel.cellViewModels, toSection: sectionViewModel)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension EmotionViewController: UICollectionViewDelegateFlowLayout {
    // cell
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 더미 셀
        let emotionString = dataSource.snapshot()
            .sectionIdentifiers[indexPath.section]
            .cellViewModels[indexPath.row]
            .emotion.rawValue
        let dummyCell = UILabel()
        dummyCell.text = emotionString
        dummyCell.applyTypography(with: .labelLargeMedium)
        dummyCell.sizeToFit()
        
        return CGSize(width: dummyCell.frame.width + 24, height: dummyCell.frame.height + 10)
    }
    // header
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 24)
    }
}

private extension EmotionViewController {
    var emotionCollectionView: UICollectionView {
        contentView.collectionView
    }
}
