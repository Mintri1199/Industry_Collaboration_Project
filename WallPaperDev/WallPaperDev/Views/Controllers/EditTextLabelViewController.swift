//
//  EditTextLabelViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit


class EditTextLabelViewController: UIViewController {
    private var labelInteraction: Bool = false
    private lazy var circleLayer = CAShapeLayer()
    private lazy var flashlightLayer = CALayer()
    private lazy var cameraLayer = CALayer()
    private lazy var textBorderLayer = CAShapeLayer()
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
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: bestFont,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        textLabel.attributedText = NSAttributedString(string: viewModel.labelText!, attributes: textAttributes)
        
        view.addSubview(textLabel)
        
        textLabel.isUserInteractionEnabled = true
        
        let moveView = UIPanGestureRecognizer(target: self, action: #selector(movingLabel(_:)))
        let scaleGesture = UIPinchGestureRecognizer(target: self, action: #selector(scaleLabel(_:)))
        scaleGesture.delegate = self
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateLabel(_:)))
        rotateGesture.delegate = self
        
        textLabel.addGestureRecognizer(moveView)
        textLabel.addGestureRecognizer(scaleGesture)
        textLabel.addGestureRecognizer(rotateGesture)
        
        textBorderLayer.frame = textLabel.bounds
        textBorderLayer.strokeColor = UIColor.white.cgColor
        textBorderLayer.fillColor = UIColor.clear.cgColor
        textBorderLayer.lineWidth = 2
        textBorderLayer.lineDashPattern = [10, 5, 5, 5]
        textBorderLayer.isHidden = true
        textBorderLayer.path = UIBezierPath(rect: textLabel.bounds).cgPath
        
        textLabel.layer.addSublayer(textBorderLayer)
    }
    
    private func animateLabelEditing() {
        let lineDashAnimation = CABasicAnimation(keyPath: "lineDashPhase")
        lineDashAnimation.fromValue = 0
        lineDashAnimation.toValue = textBorderLayer.lineDashPattern?.reduce(0) { $0 + $1.intValue }
        lineDashAnimation.duration = 1
        lineDashAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        textBorderLayer.add(lineDashAnimation, forKey: nil)
    }
}

// MARK: - OBJC functions
extension EditTextLabelViewController {
    @objc private func dismissPreview() {
        dismiss(animated: true, completion: nil)
    }
    
    //  Text label pan gesture
    @objc private func movingLabel(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            if !labelInteraction {
                textBorderLayer.isHidden = false
                animateLabelEditing()
                labelInteraction.toggle()
            }
            
            let translation = sender.translation(in: self.view)
            textLabel.center = CGPoint(x: textLabel.center.x + translation.x, y: textLabel.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        } else if sender.state == .ended {
            labelInteraction = false
            textBorderLayer.isHidden = true
            textBorderLayer.removeAllAnimations()
        }
    }
    
    @objc private func scaleLabel(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            if !labelInteraction {
                textBorderLayer.isHidden = false
                animateLabelEditing()
                labelInteraction.toggle()
            }
            sender.scale = 1
        } else if sender.state == .ended {
            labelInteraction = false
            textBorderLayer.isHidden = true
            textBorderLayer.removeAllAnimations()
        }
    }
    
    @objc private func rotateLabel(_ sender: UIRotationGestureRecognizer) {
        guard sender.view != nil, sender.view == textLabel else {
            return
        }
        
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = sender.view!.transform.rotated(by: sender.rotation)
            
            if !labelInteraction {
                textBorderLayer.isHidden = false
                animateLabelEditing()
                labelInteraction.toggle()
            }
            sender.rotation = 0
        } else if sender.state == .ended {
            labelInteraction = false
            textBorderLayer.isHidden = true
            textBorderLayer.removeAllAnimations()
        }
    }
}

extension EditTextLabelViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer.view === textLabel, otherGestureRecognizer.view === textLabel else {
            return false
        }
        
        if gestureRecognizer is UILongPressGestureRecognizer ||
            otherGestureRecognizer is UILongPressGestureRecognizer {
            return false
        }
        
        return true
    }
}

// MARK: - Protocols
extension EditTextLabelViewController: SaveChange {
    func applyChanges(_ textFrame: CGRect, _ layerRotation: CGFloat) {
    }
}
