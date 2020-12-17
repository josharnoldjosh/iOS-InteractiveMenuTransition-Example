//
//  MenuViewController.swift
//  MenuTransition
//
//  Created by Josh Arnold on 12/15/20.
//

import Foundation
import UIKit
import SnapKit


class MenuViewController : UIViewController {
    
    
    let menuBackground = UIView()
    let dollarsLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        self.view.backgroundColor = .clear
                
        menuBackground.backgroundColor = .systemBackground
        self.view.addSubview(menuBackground)
        
        dollarsLabel.text = "Menu"
        dollarsLabel.font = .systemFont(ofSize: 50, weight: .thin)
        dollarsLabel.textColor = .label
        self.menuBackground.addSubview(dollarsLabel)
        
        menuBackground.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75) // notice we set the width of this view to 75% of the current view instead of 100%
        }
        
        dollarsLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.menuBackground.safeAreaLayoutGuide).inset(20)
            make.height.lessThanOrEqualToSuperview()
        }
    }
}
