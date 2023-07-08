//
//  PlantDetailViewController.swift
//  PlantAppTransition
//
//  Created by cleanmac on 08/07/23.
//

import UIKit

final class PlantDetailViewController: UIViewController {
    
    private(set) lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.tintColor = .black
        button.alpha = 0
        return button
    }()
    
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
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.alpha = 0
        return label
    }()
    
    private(set) lazy var plantSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is plant"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.alpha = 0
        return label
    }()
    
    private(set) lazy var plantDetailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.alpha = 0
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Storyboard/XIB initializations are not supported")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1, animations: { [unowned self] in
            self.dismissButton.alpha = 1
            self.plantTitleLabel.alpha = 1
            self.plantSubtitleLabel.alpha = 1
            self.plantDetailLabel.alpha = 1
        })
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(plantImageView)
        view.addSubview(plantDescriptionContainerView)
        plantDescriptionContainerView.addSubview(plantTitleLabel)
        plantDescriptionContainerView.addSubview(plantSubtitleLabel)
        plantDescriptionContainerView.addSubview(plantDetailLabel)
        view.addSubview(dismissButton)
        
        let imageViewHeight: CGFloat = UIScreen.main.bounds.height * 0.35
        
        NSLayoutConstraint.activate([
            plantImageView.topAnchor.constraint(equalTo: view.topAnchor),
            plantImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            plantImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            plantImageView.heightAnchor.constraint(equalToConstant: imageViewHeight),
            
            plantDescriptionContainerView.topAnchor.constraint(equalTo: plantImageView.bottomAnchor, constant: -100),
            plantDescriptionContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            plantDescriptionContainerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            plantDescriptionContainerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            plantTitleLabel.topAnchor.constraint(equalTo: plantDescriptionContainerView.topAnchor, constant: 24),
            plantTitleLabel.leftAnchor.constraint(equalTo: plantDescriptionContainerView.leftAnchor, constant: 32),
            plantTitleLabel.rightAnchor.constraint(equalTo: plantDescriptionContainerView.rightAnchor, constant: -32),
            plantTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            plantSubtitleLabel.topAnchor.constraint(equalTo: plantTitleLabel.bottomAnchor, constant: 8),
            plantSubtitleLabel.leftAnchor.constraint(equalTo: plantDescriptionContainerView.leftAnchor, constant: 32),
            plantSubtitleLabel.rightAnchor.constraint(equalTo: plantDescriptionContainerView.rightAnchor, constant: -32),
            plantSubtitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            plantDetailLabel.topAnchor.constraint(equalTo: plantSubtitleLabel.bottomAnchor, constant: 32),
            //plantDetailLabel.bottomAnchor.constraint(equalTo: plantDescriptionContainerView.bottomAnchor, constant: -32),
            plantDetailLabel.leftAnchor.constraint(equalTo: plantDescriptionContainerView.leftAnchor, constant: 32),
            plantDetailLabel.rightAnchor.constraint(equalTo: plantDescriptionContainerView.rightAnchor, constant: -32),
            
            dismissButton.heightAnchor.constraint(equalToConstant: 35),
            dismissButton.widthAnchor.constraint(equalToConstant: 35),
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            dismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
        ])
        
        plantDetailLabel.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.\n\nNemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?\n\nQuis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
    }
    
    @objc private func dismissAction() {
        dismiss(animated: true)
    }

}
