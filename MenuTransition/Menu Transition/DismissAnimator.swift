//
//  DismissAnimator.swift
//  MenuTransition
//
//  Created by Josh Arnold on 12/16/20.
//

import Foundation
import UIKit


class DismissAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    
    private let menuWidth:CGFloat
    
    
    init(menuWidth:CGFloat = 1.0) {
        self.menuWidth = menuWidth
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = self.transitionDuration(using: transitionContext)
                
        guard let vc = transitionContext.view(forKey: .from) else {
            return
        }
        
        guard let dim = transitionContext.containerView.viewWithTag(49) else {
            return
        }
        
        guard let underView = transitionContext.viewController(forKey: .from)!.presentingViewController?.view else {
            return
        }
                            
        vc.frame.origin.x = 0
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [UIView.KeyframeAnimationOptions.calculationModeLinear]) {
                                 
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 1.0) {
                underView.frame.origin.x = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                dim.alpha = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                vc.frame.origin.x = -(UIScreen.main.bounds.width * self.menuWidth)
            })
        } completion: { (success) in
            if success {
                if !transitionContext.transitionWasCancelled {
                    dim.removeFromSuperview()
                }                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
