//
//  TransitionManager.swift
//  PlantAppTransition
//
//  Created by cleanmac on 08/07/23.
//

import UIKit

final class TransitionManager: NSObject {}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentationAnimator(operation: .presented)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentationAnimator(operation: .dismissed)
    }
}
