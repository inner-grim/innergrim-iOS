//
//  EmotionKeywordViewController.swift
//  innergrim
//
//  Created by 지연 on 12/29/24.
//

import Combine
import UIKit

final class EmotionKeywordViewController: BaseViewController<EmotionKeywordView> {
    private let viewModel: EmotionKeywordViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<
        EmotionKeywordSectionViewModel,
        EmotionKeywordCellViewModel
    >!
    
    // MARK: - Init
    
    init(viewModel: EmotionKeywordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(backImage: .arrowLeft)
        setupEmotionCollectionView()
        setupBindings()
        viewModel.send(.viewDidLoad)
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
                    cellType: EmotionKeywordCell.self
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
                viewType: EmotionKeywordHeader.self
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
        
        doneButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.doneButtonDidTap)
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.emotionKeywords
            .sink { [weak self] emotionKeywords in
                self?.applySnapshot(with: emotionKeywords)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with sectionViewModels: [EmotionKeywordSectionViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<
            EmotionKeywordSectionViewModel,
                EmotionKeywordCellViewModel
        >()
        
        sectionViewModels.forEach { sectionViewModel in
            snapshot.appendSections([sectionViewModel])
            snapshot.appendItems(sectionViewModel.cellViewModels, toSection: sectionViewModel)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension EmotionKeywordViewController: UICollectionViewDelegateFlowLayout {
    // 셀 크기
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
    // 헤더 크기
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 24)
    }
    // 셀 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.send(.emotionKeywordCellDidTap(indexPath: indexPath))
    }
}

private extension EmotionKeywordViewController {
    var emotionCollectionView: UICollectionView {
        contentView.collectionView
    }
    
    var doneButton: SolidButton {
        contentView.doneButton
    }
}
