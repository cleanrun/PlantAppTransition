//
//  PresentationAnimator.swift
//  PlantAppTransition
//
//  Created by cleanmac on 08/07/23.
//

import UIKit

enum PresentationOperation {
    case presented
    case dismissed
}

final class PresentationAnimator: NSObject {
    
    private let duration: TimeInterval = 0.5
    private let springDamping: CGFloat = 0.8
    private let springVelocity: CGFloat = 1
    private let operation: PresentationOperation
    
    init(operation: PresentationOperation) {
        self.operation = operation
    }
    
    private func animateTransition(from fromVC: UIViewController, to toVC: UIViewController, using context: UIViewControllerContextTransitioning) {
        switch operation {
        case .presented:
            guard
                let detailVC = toVC as? PlantDetailViewController,
                let homeVC = fromVC as? HomeViewController
            else { return }
            
            animatePresent(to: detailVC, from: homeVC, using: context)
        case .dismissed:
            guard
                let detailVC = fromVC as? PlantDetailViewController,
                let homeVC = toVC as? HomeViewController
            else { return }
            
            animateDismiss(from: detailVC, to: homeVC, using: context)
        }
    }
    
    private func animatePresent(to detailVC: PlantDetailViewController,
                                from homeVC: HomeViewController,
                                using context: UIViewControllerContextTransitioning) {
        guard let selectedCell = homeVC.selectedCell else { return }
        
        let containerView = context.containerView
        
        let cellImageView = selectedCell.plantImageView
        let cellDescriptionContainerView = selectedCell.plantDescriptionContainerView
        
        let detailImageView = detailVC.plantImageView
        
        detailVC.view.layoutIfNeeded()
        
        let snapshotImageView = UIImageView(image: cellImageView.image)
        snapshotImageView.clipsToBounds = true
        snapshotImageView.layer.cornerRadius = selectedCell.contentView.layer.cornerRadius
        snapshotImageView.frame = containerView.convert(cellImageView.frame, from: selectedCell.contentView)
        snapshotImageView.contentMode = detailImageView.contentMode
        
        let snapshotDescriptionContainerView = UIView()
        snapshotDescriptionContainerView.backgroundColor = cellDescriptionContainerView.backgroundColor
        snapshotDescriptionContainerView.layer.cornerRadius = cellDescriptionContainerView.layer.cornerRadius
        snapshotDescriptionContainerView.frame = containerView.convert(cellDescriptionContainerView.frame, from: selectedCell.contentView)
        
        containerView.addSubview(detailVC.view)
        containerView.addSubview(snapshotImageView)
        containerView.addSubview(snapshotDescriptionContainerView)
        
        detailVC.view.isHidden = true
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, animations: {
            snapshotImageView.frame = containerView.convert(detailImageView.frame, from: detailVC.view)
        })
        
        UIView.animate(withDuration: duration, delay: 0.05, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, animations: {
            snapshotDescriptionContainerView.frame = containerView.convert(detailVC.plantDescriptionContainerView.frame, from: detailVC.view)
            snapshotDescriptionContainerView.layer.cornerRadius = detailVC.plantDescriptionContainerView.layer.cornerRadius
            
        }, completion: { finished in
            snapshotImageView.removeFromSuperview()
            snapshotDescriptionContainerView.removeFromSuperview()
            detailVC.view.isHidden = false
            context.completeTransition(finished)
        })
    }
    
    private func animateDismiss(from detailVC: PlantDetailViewController,
                                to homeVC: HomeViewController,
                                using context: UIViewControllerContextTransitioning) {
        guard let selectedCell = homeVC.selectedCell else { return }
        
        let containerView = context.containerView
        
        let detailImageView = detailVC.plantImageView
        let detailDescriptionContainerView = detailVC.plantDescriptionContainerView
        
        let snapshotImageView = UIImageView(image: detailImageView.image)
        snapshotImageView.clipsToBounds = true
        snapshotImageView.contentMode = detailImageView.contentMode
        snapshotImageView.layer.cornerRadius = selectedCell.contentView.layer.cornerRadius
        snapshotImageView.frame = containerView.convert(detailImageView.frame, to: detailVC.view)
        
        let snapshotDescriptionContainerView = UIView()
        snapshotDescriptionContainerView.layer.cornerRadius = detailDescriptionContainerView.layer.cornerRadius
        snapshotDescriptionContainerView.backgroundColor = detailDescriptionContainerView.backgroundColor
        snapshotDescriptionContainerView.frame = containerView.convert(detailDescriptionContainerView.frame, from: detailVC.view)
        
        containerView.addSubview(snapshotImageView)
        containerView.addSubview(snapshotDescriptionContainerView)
        
        detailVC.view.isHidden = true
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, animations: {
            snapshotImageView.frame = containerView.convert(selectedCell.plantImageView.frame, from: selectedCell.contentView)
        })
        
        UIView.animate(withDuration: duration, delay: 0.04, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, animations: {
            snapshotDescriptionContainerView.frame = containerView.convert(selectedCell.plantDescriptionContainerView.frame, from: selectedCell.contentView)
            snapshotDescriptionContainerView.layer.cornerRadius = selectedCell.plantDescriptionContainerView.layer.cornerRadius
            
        }, completion: { finished in
            snapshotImageView.removeFromSuperview()
            snapshotDescriptionContainerView.removeFromSuperview()
            context.completeTransition(finished)
        })
        
    }
    
}

extension PresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        animateTransition(from: fromVC, to: toVC, using: transitionContext)
    }
}
