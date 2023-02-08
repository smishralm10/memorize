//
//  PlayViewController.swift
//  Memorize
//
//  Created by AB027CJ on 2023/01/28.
//

import UIKit


class PlayViewController: UICollectionViewController, Storyboarded {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Card>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Card>
    
    var dataSource: DataSource!
    
    var viewModel: PlayViewModel!
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.tintColor = .systemCyan
        label.font = UIFont.preferredFont(forTextStyle: .title1).withSize(32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        collectionView.bounces = false
        
        registerCellWithDataSource()
        updateSnapshot()
        setupUI()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PlayCollectionViewCell
        let card = dataSource.itemIdentifier(for: indexPath)
        guard let cell = cell, let card  = card else { return }

        UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromRight], animations: {
            cell.cardImageView.image = card.image.image
            cell.isFlipped = true
        }) { _ in
                let (match, cards) = self.viewModel.shouldMatchCard(with: indexPath)
                if !match && !cards.isEmpty {
                    cards.forEach { indexPath in
                        guard let cell = collectionView.cellForItem(at: indexPath) as? PlayCollectionViewCell else { return }
                        
                        UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromLeft) {
                            cell.cardImageView.image = UIImage(named: "card-background")
                        }
                        cell.isFlipped = false
                    }
                }
            }
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath)
                as? PlayCollectionViewCell
        else { return false }
        return !cell.isFlipped
    }
    
    private func setupUI() {
        view.addSubview(timeLabel)
        navigationItem.titleView = timeLabel
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func registerCellWithDataSource() {
        dataSource = DataSource(collectionView: collectionView,
                                cellProvider: { collectionView, indexPath, card in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PlayCollectionViewCell.reuseIdentifier,
                for: indexPath) as? PlayCollectionViewCell else { return UICollectionViewCell() }
            return cell
        })
        
        collectionView.register(
            PlayHeaderReusableView.self,
            forSupplementaryViewOfKind: PlayHeaderReusableView.elementKind,
            withReuseIdentifier: PlayHeaderReusableView.reuseIdentifier)
        
        dataSource.supplementaryViewProvider = { [unowned self] (collectionView, kind, indexPath)
            -> UICollectionReusableView? in
            switch kind {
            case PlayHeaderReusableView.elementKind:
                let header = self.collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: PlayHeaderReusableView.reuseIdentifier,
                    for: indexPath) as? PlayHeaderReusableView
                header?.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 150)
                return header
            default:
                fatalError("No element specified with this elementKind")
            }
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                                  heightDimension: .absolute(120))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(140))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.1), heightDimension: .absolute(150))
                                                
            group.interItemSpacing = .fixed(20)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0)
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: PlayHeaderReusableView.elementKind,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }
    
    private func updateSnapshot() {
        let cards = viewModel.cards
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(cards ,toSection: 0)
        dataSource.apply(snapshot)
    }
}
