//
//  EditTextLabelViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class EditTextLabelViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var viewModel = EditTextViewModel()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: viewModel.labelFrame!)
        label.numberOfLines = 10
        return label
    }()
    
    lazy var livePreview: UIImageView = {
        let view = UIImageView(frame: UIScreen.main.bounds)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupLivePreview()
        setupDraggablelabel()
        
    }
}

// MARK: - UIs functions
extension EditTextLabelViewController {
    private func setupLivePreview() {
        view.addSubview(livePreview)
        livePreview.backgroundColor = .white
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissPreview))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    private func setupDraggablelabel() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let bestFont = UIFont.bestFittingFont(for: self.viewModel.labelText!,
                                              in: self.viewModel.labelFrame!,
                                              fontDescriptor: UIFontDescriptor(name: "Helvetica Bold", size: 20))
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : bestFont,
            NSAttributedString.Key.paragraphStyle : paragraphStyle
        ]
        textLabel.attributedText = NSAttributedString(string: viewModel.labelText!, attributes: textAttributes)
        
        view.addSubview(textLabel)
    }
}

// MARK: - OBJC functions
extension EditTextLabelViewController {
    @objc private func dismissPreview() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Protocols
extension EditTextLabelViewController: SaveChange {
    func applyChanges(_ textFrame: CGRect, _ layerRotation: CGFloat) {
    }
}
