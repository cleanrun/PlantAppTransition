//
//  PresentationController.swift
//  PlantAppTransition
//
//  Created by cleanmac on 08/07/23.
//

import UIKit

final class PresentationController: UIPresentationController {
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.8)
        return view
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else { return .zero }
        return containerView.frame
    }

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView, let coordinator = presentedViewController.transitionCoordinator else { return }
        
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dimmingView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            dimmingView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
        ])
        
        coordinator.animate(alongsideTransition: { [unowned self] _ in
            self.dimmingView.alpha = 1
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { [unowned self] _ in
            self.dimmingView.alpha = 0.0
        })
    }

    override func containerViewWillLayoutSubviews() {
        
    }
}
