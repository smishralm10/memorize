//
//  PlayHeaderReusableView.swift
//  Memorize
//
//  Created by AB027CJ on 2023/02/05.
//

import UIKit

class PlayHeaderReusableView: UICollectionReusableView {
    static let elementKind = "playHeaderReusableView"
    static let reuseIdentifier = "playHeaderViewIdentifier"
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let leftVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let rightVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.tintColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let levelTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Level"
        label.tintColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray3
        label.font = UIFont.preferredFont(forTextStyle: .body).withSize(24)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray3
        label.font = UIFont.preferredFont(forTextStyle: .body).withSize(24)
        label.textAlignment = .center
        label.layer.cornerRadius = label.frame.width / 2
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius = ((horizontalStackView.bounds.width / 2) * 0.4) / 2
        scoreLabel.layer.cornerRadius = cornerRadius
        levelLabel.layer.cornerRadius = cornerRadius
    }
    
    private func setupUI() {
        leftVerticalStackView.addArrangedSubview(scoreLabel)
        leftVerticalStackView.addArrangedSubview(scoreTitleLabel)
        rightVerticalStackView.addArrangedSubview(levelLabel)
        rightVerticalStackView.addArrangedSubview(levelTitleLabel)
        horizontalStackView.addArrangedSubview(leftVerticalStackView)
        horizontalStackView.addArrangedSubview(rightVerticalStackView)
        addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            scoreTitleLabel.widthAnchor.constraint(equalTo: leftVerticalStackView.widthAnchor),
            levelTitleLabel.widthAnchor.constraint(equalTo: rightVerticalStackView.widthAnchor),
            
            scoreLabel.widthAnchor.constraint(equalTo: rightVerticalStackView.widthAnchor, multiplier: 0.4),
            scoreLabel.heightAnchor.constraint(equalTo: scoreLabel.widthAnchor, multiplier: 1),
            
            levelLabel.widthAnchor.constraint(equalTo: leftVerticalStackView.widthAnchor, multiplier: 0.4),
            levelLabel.heightAnchor.constraint(equalTo: levelLabel.widthAnchor, multiplier: 1)
        ])
        
    }
}

