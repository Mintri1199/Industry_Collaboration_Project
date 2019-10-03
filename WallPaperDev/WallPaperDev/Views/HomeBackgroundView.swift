//
//  HomeTitleView.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class HomeBackgroundView: UIView {
    
    private let morningTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Good Morning"
        label.textColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Avenir-Black", size: 40)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let currentDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Avenir-Medium", size: 25)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =  #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        addSubview(morningTitleLabel)
        addSubview(currentDateLabel)
        setDateLabel()
        titleConstraint()
        dateLabelConstraint()
    }
    
    private func setDateLabel() {
        currentDateLabel.text = getDateString()
    }
    
    private func getDateString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.none
        return "It is \(formatter.string(from: date))"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func titleConstraint() {
        morningTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        morningTitleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 4).isActive = true
        morningTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 10).isActive = true
        morningTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        morningTitleLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func dateLabelConstraint() {
        currentDateLabel.translatesAutoresizingMaskIntoConstraints = false
        currentDateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        currentDateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        currentDateLabel.leftAnchor.constraint(equalTo: morningTitleLabel.leftAnchor).isActive = true
        currentDateLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 25).isActive = true
    }
}
