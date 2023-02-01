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
        let cell = collectionView.cellForItem(at: indexPath) as? PlayCollectionViewCell
        let card = dataSource.itemIdentifier(for: indexPath)
        guard let cell = cell, let card  = card else { return }

        if cell.imageIdentifier == nil {
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromRight) {
                cell.cardImageView.image = card.image.image
                cell.imageIdentifier = card.image.id
            }
        }
    }
    
    
    private func registerCellWithDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, card in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayCollectionViewCell.reuseIdentifier, for: indexPath) as? PlayCollectionViewCell else { return UICollectionViewCell() }
            return cell
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
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Card.sampleData(), toSection: 0)
        dataSource.apply(snapshot)
    }
}
