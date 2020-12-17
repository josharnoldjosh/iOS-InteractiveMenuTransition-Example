//
//  PresentationAnimator.swift
//  MenuTransition
//
//  Created by Josh Arnold on 12/15/20.
//

import Foundation
import UIKit


class PresentationAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    
    private let menuWidth:CGFloat
    
    
    init(menuWidth:CGFloat = 1.0) {
        self.menuWidth = menuWidth
        super.init()
    }    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
                        
        guard let vc = transitionContext.view(forKey: .to) else {
            return
        }
        
        let duration = self.transitionDuration(using: transitionContext)
        
        let dim = UIView()
        dim.frame = vc.bounds
        dim.backgroundColor = .systemGray
        dim.alpha = 0
        dim.tag = 49 // Unqiue tag
        transitionContext.containerView.addSubview(dim)
        
        vc.frame.origin.x = 0
        vc.frame.origin.x -= (UIScreen.main.bounds.width*self.menuWidth)
        transitionContext.containerView.addSubview(vc)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: []) {
                                
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 1.0) {
                transitionContext.viewController(forKey: .from)?.view.frame.origin.x = 75
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.35, relativeDuration: 1.0) {
                vc.layer.shadowOpacity = 0.15
                vc.layer.shadowOffset = CGSize(width: 1, height: 1)
                vc.layer.shadowColor = UIColor.black.cgColor
                vc.layer.shadowRadius = 12.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                dim.alpha = 0.5
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                vc.frame.origin.x = 0
            })
            
        } completion: { (success) in
            if success {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
