//
//  CustomTransition.swift
//  MenuTransition
//
//  Created by Josh Arnold on 12/15/20.
//

import Foundation
import UIKit
import Closures


class CustomTransition : NSObject, UIViewControllerTransitioningDelegate {
    
    
    private var menuWidth:CGFloat
    private var startVC, finishVC:UIViewController!
    var isInteractive:Bool = false
    var interactiveCoordinator:UIPercentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
    
    
    init(menuWidth:CGFloat = 0.75) {
        self.menuWidth = menuWidth
        super.init()
    }    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimator(menuWidth: self.menuWidth)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator(menuWidth: self.menuWidth)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractive ? interactiveCoordinator : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractive ? interactiveCoordinator : nil
    }
}


/**
 * Functions to handle the panning of the menu.
 * Notice we call "present" or "dismiss" and set "isInteractive" to true when we start the interactive transition.
 * From there we simply update the progress.
 */
extension CustomTransition {
    
    func setupPan(startVC:UIViewController, finishVC:UIViewController) {
        
        self.startVC = startVC
        self.finishVC = finishVC
        
        startVC.view.addPanGesture { (pan) in
            self.startPan(pan: pan)
        }
        
        finishVC.view.addPanGesture { (pan) in
            self.finishPan(pan: pan)
        }
    }
    
    private func startPan(pan:UIPanGestureRecognizer) {
                        
        let distance = pan.translation(in: pan.view).x / (pan.view!.bounds.size.width) // A.K.A the progress of the transition.
                                                    
        self.interactiveCoordinator.completionSpeed = 1.1 - distance
        
        if pan.state == .began {
            self.isInteractive = true
            self.startVC.present(self.finishVC, animated: true, completion: nil)            
        } else if pan.state == .changed {
            self.interactiveCoordinator.update(distance)            
        } else {
            self.isInteractive = false
            if pan.velocity(in: pan.view).x < 0 {
                self.interactiveCoordinator.cancel()
            } else {
                self.interactiveCoordinator.finish()
            }
        }
    }
        
    private func finishPan(pan:UIPanGestureRecognizer) {
                
        let distance = -(pan.translation(in: pan.view).x / (pan.view!.bounds.size.width)) // A.K.A the progress of the transition.
                
        self.interactiveCoordinator.completionSpeed = 1.1 - distance
        
        if pan.state == .began {
            self.isInteractive = true
            self.finishVC.dismiss(animated: true, completion: nil)
        } else if pan.state == .changed {
            self.interactiveCoordinator.update(distance)
        } else {
            self.isInteractive = false
            if pan.velocity(in: pan.view).x > 0 {
                self.interactiveCoordinator.cancel()
            } else {
                self.interactiveCoordinator.finish()
            }
        }
    }
}
