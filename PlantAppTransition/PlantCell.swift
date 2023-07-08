//
//  PlantCell.swift
//  PlantAppTransition
//
//  Created by cleanmac on 08/07/23.
//

import UIKit

final class PlantCell: UICollectionViewCell {
    static var CELL_WIDTH: CGFloat { UIScreen.main.bounds.width * 0.6 }
    static var CELL_HEIGHT: CGFloat { UIScreen.main.bounds.width * 0.9 }
    static var CELL_IDENTIFIER: String { String(describing: self) }
    
    private(set) lazy var plantImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "plant-image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) lazy var plantDescriptionContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private(set) lazy var plantTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some plant"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private(set) lazy var plantSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is plant"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Storyboard/XIB initializations are not supported")
    }
    
    private func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(plantImageView)
        contentView.addSubview(plantDescriptionContainerView)
        plantDescriptionContainerView.addSubview(plantTitleLabel)
        plantDescriptionContainerView.addSubview(plantSubtitleLabel)
        
        NSLayoutConstraint.activate([
            plantImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            plantImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            plantImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            plantImageView.heightAnchor.constraint(equalToConstant: PlantCell.CELL_HEIGHT * 0.7),
            
            plantDescriptionContainerView.topAnchor.constraint(equalTo: plantImageView.bottomAnchor, constant: -24),
            plantDescriptionContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            plantDescriptionContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            plantDescriptionContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            plantTitleLabel.topAnchor.constraint(equalTo: plantDescriptionContainerView.topAnchor, constant: 16),
            plantTitleLabel.leftAnchor.constraint(equalTo: plantDescriptionContainerView.leftAnchor, constant: 24),
            plantTitleLabel.rightAnchor.constraint(equalTo: plantDescriptionContainerView.rightAnchor, constant: -24),
            
            plantSubtitleLabel.topAnchor.constraint(equalTo: plantTitleLabel.bottomAnchor, constant: 16),
            plantSubtitleLabel.leftAnchor.constraint(equalTo: plantDescriptionContainerView.leftAnchor, constant: 24),
            plantSubtitleLabel.rightAnchor.constraint(equalTo: plantDescriptionContainerView.rightAnchor, constant: -24),
        ])
    }
}
