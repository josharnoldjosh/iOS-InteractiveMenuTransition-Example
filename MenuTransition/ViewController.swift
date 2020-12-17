//
//  ViewController.swift
//  MenuTransition
//
//  Created by Josh Arnold on 12/15/20.
//

import UIKit
import SnapKit
import Closures


class ViewController: UIViewController {
    
    
    private var transition = CustomTransition(menuWidth: 0.75)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupTransition()
    }

    func setupUI() {
                
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = "Menu Transition Example"
        titleLabel.textColor = .label
        view.addSubview(titleLabel)
        
        let content = UILabel()
        content.font = .systemFont(ofSize: 12)
        content.text = "Swipe right to view the menu!"
        content.numberOfLines = 0
        content.textColor = .systemGray
        view.addSubview(content)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.lessThanOrEqualToSuperview()
        }
        
        content.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.lessThanOrEqualToSuperview()
        }
    }
    
    func setupTransition() {
        
        // This is the viewcontroller we want as our menu
        let vc = MenuViewController()
        
        // Pretty much the only three lines of code we need to set to use our transition
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.transition
        self.transition.setupPan(startVC: self, finishVC: vc)
    }
}
