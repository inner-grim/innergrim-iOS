//
//  HomeViewController.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func navigateToKeywordViewController()
    func navigateToPictureDiaryViewController()
    func navigateToSettingsViewController()
}

final class HomeViewController: BaseViewController<HomeView> {
    weak var delegate: HomeViewControllerDelegate?
    private let viewModel: HomeViewModel
    private var calendarDataSource: UICollectionViewDiffableDataSource<Int, CalendarCellViewModel>!
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifeycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden()
        setupCalendarView()
        setupBindings()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        configureBottomSafeArea()
    }
    
    // MARK: - Setup Methods
    
    private func setupCalendarView() {
        calendarView.delegate = self
        
        calendarDataSource = UICollectionViewDiffableDataSource<Int, CalendarCellViewModel>(
            collectionView: calendarView
            , cellProvider: { (collectionView, indexPath, viewModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: CalendarCell.self
                )
                cell.configure(with: viewModel)
                return cell
            }
        )
    }
    
    private func setupBindings() {
        // action
        settingsButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                generateHaptic()
                delegate?.navigateToSettingsViewController()
            }
            .store(in: &cancellabels)
        
        shareTodayButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                generateHaptic()
                delegate?.navigateToKeywordViewController()
            }
            .store(in: &cancellabels)
        
        // state
        viewModel.state.calendarCellViewModels
            .receive(on: RunLoop.main)
            .sink { [weak self] cellViewModels in
                self?.applySnapshot(with: cellViewModels)
            }
            .store(in: &cancellabels)
    }
    
    private func applySnapshot(with calendarCellViewModels: [CalendarCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CalendarCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(calendarCellViewModels, toSection: 0)
        calendarDataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 40, height: 58)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        // 7개의 아이템이 들어가도록 설정
        let totalItemWidth: CGFloat = 40 * 7
        let totalSpacingWidth: CGFloat = collectionView.bounds.width - totalItemWidth
        let interitemSpacing = totalSpacingWidth / 6
        return max(0, interitemSpacing)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 12 // row 간 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        generateHaptic()
        delegate?.navigateToPictureDiaryViewController()
    }
}

private extension HomeViewController {
    var settingsButton: UIButton {
        contentView.settingsButton
    }
    
    var calendarView: UICollectionView {
        contentView.calendarView.collectionView
    }
    
    var shareTodayButton: SolidButton {
        contentView.shareTodayButton
    }
}
