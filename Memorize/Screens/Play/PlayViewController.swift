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
    
    weak var viewModel: PlayViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        
        navigationItem.title = "Play"
        navigationController?.navigationBar.prefersLargeTitles = true
        registerCellWithDataSource()
        updateSnapshot()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let card = dataSource.itemIdentifier(for: indexPath)
        guard let cell = cell, let card  = card else { return }
        
        UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromRight) {
            cell.backgroundView = card.backView
            cell.backgroundView?.layer.cornerRadius = cell.bounds.width * 0.1
        }
    }
    
//        UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromLeft) {
//            cell.backgroundView = card.frontView
//        }
    
    private func registerCellWithDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
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
                                                
            group.interItemSpacing = .fixed(20)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0)
            
            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }
    
    private func cellRegistrationHandler(cell: UICollectionViewCell, indexPath: IndexPath, card: Card) {
        cell.backgroundView = card.frontView
        cell.backgroundView?.layer.cornerRadius = cell.bounds.width * 0.1
        cell.layer.cornerRadius = cell.bounds.width * 0.1
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Card.sampleData(), toSection: 0)
        dataSource.apply(snapshot)
    }
}
