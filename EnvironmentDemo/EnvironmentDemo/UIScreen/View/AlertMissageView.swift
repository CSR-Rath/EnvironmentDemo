//
//  AlertMissageView.swift
//  EnvironmentDemo
//
//  Created by Rath! on 6/6/24.
//

import UIKit

class AlertMissageView: UIView {
    
    let lblTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        addSubview(lblTitle)
        lblTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lblTitle.textColor = .white
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lblTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



