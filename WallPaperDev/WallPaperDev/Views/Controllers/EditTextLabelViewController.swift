//
//  EditTextLabelViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class EditTextLabelViewController: UIViewController {
  //    private var bottomToolBar: UIToolbar
  private var labelInteraction: Bool = false
  private lazy var flashlightLayer = CALayer()
  private lazy var cameraLayer = CALayer()
  private lazy var textBorderLayer = CAShapeLayer()
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }

  private lazy var toolBar = UIToolbar(frame: .zero)
//    TODO: Figure out how to make the tool bar shrink down when the user interact with the label
//    private lazy var heightContraint: NSLayoutConstraint? = nil
//    private lazy var toolBarBottomContraint: NSLayoutConstraint? = nil
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
    setupLivePreview()
    setupDraggablelabel()
    setupIconsLayers()
    setupToolBar()
  }

  private func toggleIcons(_ isHidden: Bool) {
    flashlightLayer.isHidden = isHidden
    cameraLayer.isHidden = isHidden
  }

  private func showToolBar(_ isHidden: Bool) {
    UIView.animate(withDuration: 0.5) {
      self.toolBar.isHidden = isHidden
    }
  }
}

// MARK: - UIs functions

extension EditTextLabelViewController {

  private func setupLivePreview() {
    view.addSubview(livePreview)
    livePreview.backgroundColor = .white
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissPreview))
    swipeDown.direction = .down
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(unhideToolBar))
    view.addGestureRecognizer(swipeDown)
    view.addGestureRecognizer(tapGesture)
  }

  private func setupDraggablelabel() {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center

    let bestFont = UIFont.bestFittingFont(for: viewModel.labelText!,
                                          in: viewModel.labelFrame!,
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
//        textLabel.addGestureRecognizer(scaleGesture)
//        textLabel.addGestureRecognizer(rotateGesture)

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

  private func setupIconsLayers() {
    let layerSize: CGSize = CGSize(width: view.bounds.width / 8, height: view.bounds.width / 8)

    let cameraCircleLayer = CAShapeLayer()
    let flashlightCircleLayer = CAShapeLayer()

    flashlightLayer.frame = CGRect(origin: CGPoint(x: view.bounds.width / 8.3, y: view.bounds.height * 0.88), size: layerSize)
    cameraLayer.frame = CGRect(origin: CGPoint(x: view.bounds.width - ((view.bounds.width / 8.3) + layerSize.width), y: view.bounds.height * 0.88), size: layerSize)

    cameraCircleLayer.path = UIBezierPath(ovalIn: cameraLayer.bounds).cgPath
    flashlightCircleLayer.path = UIBezierPath(ovalIn: flashlightLayer.bounds).cgPath

    cameraLayer.backgroundColor = UIColor(white: 0, alpha: 0.2).cgColor
    flashlightLayer.backgroundColor = UIColor(white: 0, alpha: 0.2).cgColor

    cameraLayer.mask = cameraCircleLayer
    flashlightLayer.mask = flashlightCircleLayer

    let cameraImageLayer = CALayer()
    cameraImageLayer.contentsGravity = .resizeAspect
    cameraImageLayer.frame = CGRect(origin: .zero, size: CGSize(width: flashlightLayer.bounds.size.width * 0.5, height: flashlightLayer.bounds.size.height * 0.5))
    cameraImageLayer.contents = UIImage(named: "camera")?.cgImage
    cameraImageLayer.position = CGPoint(x: cameraLayer.bounds.midX, y: cameraLayer.bounds.midY)

    let flashflightImageLayer = CALayer()
    flashflightImageLayer.contentsGravity = .resizeAspect
    flashflightImageLayer.frame = CGRect(origin: .zero, size: CGSize(width: flashlightLayer.bounds.size.width * 0.5, height: flashlightLayer.bounds.size.height * 0.5))
    flashflightImageLayer.position = CGPoint(x: flashlightLayer.bounds.midX, y: flashlightLayer.bounds.midY)
    flashflightImageLayer.contents = UIImage(named: "flashlight")?.cgImage

    cameraLayer.addSublayer(cameraImageLayer)
    flashlightLayer.addSublayer(flashflightImageLayer)
    cameraLayer.isHidden = true
    flashlightLayer.isHidden = true
    view.layer.insertSublayer(cameraLayer, above: textLabel.layer)
    view.layer.insertSublayer(flashlightLayer, above: textLabel.layer)
  }

  private func setupToolBar() {
    toolBar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(toolBar)
    NSLayoutConstraint.activate([
      toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      toolBar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])

    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissPreview))
    let hideToolBar = UIBarButtonItem(title: Localized.string("view_action"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(hideToolbar))
    let items: [UIBarButtonItem] = [ cancelButton,
                                     UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                                     saveButton,
                                     UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                                     hideToolBar ]

    toolBar.setItems(items, animated: true)
  }
}

// MARK: - OBJC functions

extension EditTextLabelViewController {
  @objc private func dismissPreview() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func unhideToolBar() {
    showToolBar(false)
    toggleIcons(true)
  }

  @objc private func saveTapped() {
    viewModel.updateText(newFrame: textLabel.frame, newRotation: viewModel.newRotation ?? 0)
    dismissPreview()
  }

  @objc private func hideToolbar() {
    showToolBar(true)
    toggleIcons(false)
  }

  @objc private func movingLabel(_ sender: UIPanGestureRecognizer) {
    if sender.state == .began || sender.state == .changed {
      if !labelInteraction {
        textBorderLayer.isHidden = false
        animateLabelEditing()
        toggleIcons(false)
        showToolBar(true)
        labelInteraction.toggle()
      }

      let translation = sender.translation(in: view)
      textLabel.center = CGPoint(x: textLabel.center.x + translation.x, y: textLabel.center.y + translation.y)
      sender.setTranslation(CGPoint.zero, in: view)
    } else if sender.state == .ended {
      labelInteraction = false
      textBorderLayer.isHidden = true
      toggleIcons(true)
      showToolBar(false)
      textBorderLayer.removeAllAnimations()
    }
  }

  @objc private func scaleLabel(_ sender: UIPinchGestureRecognizer) {
    if sender.state == .began || sender.state == .changed {
      sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
      if !labelInteraction {
        textBorderLayer.isHidden = false
        animateLabelEditing()
        toggleIcons(false)
        showToolBar(true)
        labelInteraction.toggle()
      }
      sender.scale = 1
    } else if sender.state == .ended {
      labelInteraction = false
      textBorderLayer.isHidden = true
      toggleIcons(true)
      showToolBar(false)
      textBorderLayer.removeAllAnimations()
    }
  }

  @objc private func rotateLabel(_ sender: UIRotationGestureRecognizer) {
    guard sender.view != nil, sender.view == textLabel else {
      return
    }

    if sender.state == .began || sender.state == .changed {
      viewModel.newRotation = sender.rotation
      sender.view?.transform = sender.view!.transform.rotated(by: sender.rotation)

      if !labelInteraction {
        textBorderLayer.isHidden = false
        animateLabelEditing()
        toggleIcons(false)
        showToolBar(true)
        labelInteraction.toggle()
      }
      sender.rotation = 0
    } else if sender.state == .ended {
      labelInteraction = false
      textBorderLayer.isHidden = true
      toggleIcons(true)
      showToolBar(false)
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
