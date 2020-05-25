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
  private lazy var timeLayer = CATextLayer()
  private lazy var dateLayer = CATextLayer()
  private lazy var textBorderLayer = CAShapeLayer()
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }

  private lazy var toolBar = UIToolbar(frame: .zero)
//    TODO: Figure out how to make the tool bar shrink down when the user interact with the label
  private var heightContraint: NSLayoutConstraint?
//    private lazy var toolBarBottomContraint: NSLayoutConstraint? = nil
  var viewModel: EditTextViewModel
  private lazy var textLabel: UILabel = {
    let label = UILabel(frame: viewModel.labelFrame)
    label.numberOfLines = 10
    return label
  }()

  lazy var imagePreview: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    return view
  }()

  init(object textObject: EditLabelObject) {
    viewModel = EditTextViewModel(textObject)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLivePreview()
    setupDraggablelabel()
    setupIconsLayers()
    setupToolBar()
    setupGestureRecognizers()
    setupTimeDateLayers()
  }

  private func toggleIcons(_ isHidden: Bool) {
    flashlightLayer.isHidden = isHidden
    cameraLayer.isHidden = isHidden
    dateLayer.isHidden = isHidden
    timeLayer.isHidden = isHidden
  }

  private func showToolBar(_ isHidden: Bool) {
    UIView.animate(withDuration: 0.5) {
      self.toolBar.isHidden = isHidden
    }
  }

  private func viewShouldBeInBounds(for senderView: UIView) {
    let keywindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    let statusFrame = keywindow?.windowScene?.statusBarManager?.statusBarFrame
    // Restrict x axis from going too far left
    if senderView.frame.origin.x < 0.0 {
      senderView.frame.origin = CGPoint(x: 0.0, y: senderView.frame.origin.y)
    }

    // Restrict y axis from going too far up
    if senderView.frame.origin.y < statusFrame!.height {
      senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: statusFrame!.height)
    }

    // Restrict x axis from going too far right
    if senderView.frame.origin.x + senderView.frame.size.width > view.frame.width {
      senderView.frame.origin = CGPoint(x: view.frame.width - senderView.frame.size.width, y: senderView.frame.origin.y)
    }

    // Restrict y axis from going too far down
    if senderView.frame.origin.y + senderView.frame.size.height > view.frame.height {
      senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: view.frame.height - senderView.frame.size.height)
    }
  }
}

// MARK: - UIs functions
extension EditTextLabelViewController {

  private func setupLivePreview() {
    view.addSubview(imagePreview)

    NSLayoutConstraint.activate([
      imagePreview.topAnchor.constraint(equalTo: view.topAnchor),
      imagePreview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imagePreview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imagePreview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func setupGestureRecognizers() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(unhideToolBar))
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissPreview))
    swipeDown.direction = .down

    view.addGestureRecognizer(swipeDown)
    view.addGestureRecognizer(tapGesture)

    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(movingLabel(_:)))
    textLabel.addGestureRecognizer(panGesture)
    panGesture.delegate = self

    let scaleGesture = UIPinchGestureRecognizer(target: self, action: #selector(scaleLabel(_:)))
    scaleGesture.delegate = self

//    let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateLabel(_:)))
//    rotateGesture.delegate = self

    textLabel.addGestureRecognizer(scaleGesture)
//    textLabel.addGestureRecognizer(rotateGesture)
  }

  private func setupDraggablelabel() {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center

    let bestFont = UIFont.bestFittingFont(for: viewModel.labelText,
                                          in: viewModel.labelFrame,
                                          fontDescriptor: ApplicationDependency.manager.currentTheme.fontSchema.heavy20.fontDescriptor)

    let textAttributes: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.font: bestFont,
      NSAttributedString.Key.paragraphStyle: paragraphStyle,
      NSAttributedString.Key.foregroundColor: ApplicationDependency.manager.currentTheme.colors.white
    ]
    textLabel.attributedText = NSAttributedString(string: viewModel.labelText, attributes: textAttributes)
    view.addSubview(textLabel)

    textLabel.isUserInteractionEnabled = true
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
    cameraImageLayer.position = CGPoint(x: cameraLayer.bounds.midX, y: cameraLayer.bounds.midY)
    cameraImageLayer.frame = CGRect(origin: .zero,
                                    size: CGSize(width: flashlightLayer.bounds.size.width * 0.5, height: flashlightLayer.bounds.size.height * 0.5))
    cameraImageLayer.position = CGPoint(x: cameraLayer.bounds.midX, y: cameraLayer.bounds.midY)
    cameraImageLayer.backgroundColor = ApplicationDependency.manager.currentTheme.colors.white.cgColor

    let cameraMask = CALayer()
    cameraMask.contentsGravity = .resizeAspect
    cameraMask.frame = cameraImageLayer.bounds
    cameraMask.contents = UIImage(systemName: "camera.fill")?.cgImage
    cameraImageLayer.mask = cameraMask

    let flashflightImageLayer = CALayer()
    flashflightImageLayer.contentsGravity = .resizeAspect
    flashflightImageLayer.frame = CGRect(origin: .zero, size: CGSize(width: flashlightLayer.bounds.size.width * 0.5, height: flashlightLayer.bounds.size.height * 0.5))
    flashflightImageLayer.position = CGPoint(x: flashlightLayer.bounds.midX, y: flashlightLayer.bounds.midY)
    flashflightImageLayer.backgroundColor = ApplicationDependency.manager.currentTheme.colors.white.cgColor

    let flashlightMask = CALayer()
    flashlightMask.contentsGravity = .resizeAspect
    flashlightMask.frame = flashflightImageLayer.bounds
    flashlightMask.contents = UIImage(systemName: "flashlight.off.fill")?.cgImage
    flashflightImageLayer.mask = flashlightMask

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

  private func setupTimeDateLayers() {
    let timeFormatter = DateFormatter()

    let localSetting = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)
    if !(localSetting?.contains("a") ?? false) {
      timeFormatter.dateFormat = "H:mm"
    } else {
      timeFormatter.dateFormat = "h:mm"
    }

    let dayFormatter = DateFormatter()
    dayFormatter.dateFormat = "EEEE, MMM d"
    let timeString = timeFormatter.string(from: Date())
    let dateString = dayFormatter.string(from: Date())

    let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    let statusFrame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame
    let defaultSize = CGSize(width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.size.height / 8)
    let defaultOrigin = CGPoint(x: UIScreen.main.bounds.midX - (defaultSize.width / 2), y: statusFrame!.size.height + defaultSize.height / 2)

    timeLayer.frame = CGRect(origin: defaultOrigin, size: defaultSize)
    timeLayer.alignmentMode = .center
    let attributedString = NSAttributedString(
      string: timeString,
      attributes: [NSAttributedString.Key.font: UIFont.bestFittingFont(for: timeString,
                                                                       in: timeLayer.bounds,
                                                                       fontDescriptor: ApplicationDependency.manager.currentTheme.fontSchema.light20.fontDescriptor),
                   NSAttributedString.Key.foregroundColor: ApplicationDependency.manager.currentTheme.colors.white.cgColor])
    timeLayer.string = attributedString

    dateLayer.frame = CGRect(origin: CGPoint(x: defaultOrigin.x, y: timeLayer.frame.maxY), size: CGSize(width: defaultSize.width, height: defaultSize.height / 2))
    dateLayer.alignmentMode = .center
    let dateAttributedString = NSAttributedString(
      string: dateString,
      attributes: [NSAttributedString.Key.font: UIFont.bestFittingFont(for: dateString,
                                                                       in: dateLayer.bounds,
                                                                       fontDescriptor: ApplicationDependency.manager.currentTheme.fontSchema.regular20.fontDescriptor),
                   NSAttributedString.Key.foregroundColor: ApplicationDependency.manager.currentTheme.colors.white.cgColor])

    dateLayer.string = dateAttributedString

    dateLayer.isHidden = true
    timeLayer.isHidden = true
    view.layer.insertSublayer(dateLayer, above: textLabel.layer)
    view.layer.insertSublayer(timeLayer, above: textLabel.layer)
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
    viewModel.delegate?.applyChanges(textLabel.frame, viewModel.newRotation ?? 0)
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

      if let senderView = sender.view {
        viewShouldBeInBounds(for: senderView)
      }

      if let centerX = sender.view?.center.x, let centerY = sender.view?.center.y {
        sender.view?.center = CGPoint(x: centerX + translation.x, y: centerY + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
      }
    } else if sender.state == .ended {
      if let senderView = sender.view {
        viewShouldBeInBounds(for: senderView)
      }

      labelInteraction = false
      textBorderLayer.isHidden = true
      toggleIcons(true)
      showToolBar(false)
      textBorderLayer.removeAllAnimations()
    }
  }

  @objc private func scaleLabel(_ sender: UIPinchGestureRecognizer) {
    // Prevent the user from scaling too big or too small
    if let senderView = sender.view, sender.state == .began || sender.state == .changed {

      let newSize = CGSize(width: senderView.frame.width * sender.scale, height: senderView.frame.height * sender.scale)

      // Prevent the text from scaling too large or too small
      if (25 ..< self.view.bounds.height) ~= newSize.height && (25 ..< self.view.bounds.width) ~= newSize.width {
        senderView.transform = senderView.transform.scaledBy(x: sender.scale, y: sender.scale)
      }

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
