//
//  HomeViewController.swift
//  PlantAppTransition
//
//  Created by cleanmac on 08/07/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
    private var transitionManager = TransitionManager()
    
    private(set) var selectedCell: PlantCell? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Storyboard/XIB initializations are not supported")
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 24
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlantCell.self, forCellWithReuseIdentifier: PlantCell.CELL_IDENTIFIER)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            collectionView.heightAnchor.constraint(equalToConstant: PlantCell.CELL_HEIGHT + 20),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 1 ? 5 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantCell.CELL_IDENTIFIER, for: indexPath) as! PlantCell
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        indexPath.section == 1 ? CGSize(width: PlantCell.CELL_WIDTH, height: PlantCell.CELL_HEIGHT) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        section != 1 ? UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath) as? PlantCell
        
        let detailVC = PlantDetailViewController()
        detailVC.modalPresentationStyle = .custom
        detailVC.transitioningDelegate = transitionManager
        present(detailVC, animated: true)
    }
}

