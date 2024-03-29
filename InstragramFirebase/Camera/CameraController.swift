//
//  CameraController.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/2/19.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate, UIViewControllerTransitioningDelegate {

    // MARK: dismiss and present
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "right_arrow_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    private let capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        return button
    }()
    
    private let customAnimationPresentor = CustomAnimationPresentor()
    private let customAnimationDismisser = CustomAnimationDissmissor()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return customAnimationPresentor
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return customAnimationDismisser
    }
    
    @objc private func handleCapturePhoto() {
        
        let settings = AVCapturePhotoSettings()
        
        // do not execute camera capture for simulator
        #if (!arch(x86_64))
            guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
            
            settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]
            
            output.capturePhoto(with: settings, delegate: self)
        #endif
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        let imageData = photo.fileDataRepresentation()
        
        let previewImage = UIImage(data: imageData!)
        
        let containerView = PreviewPhotoContainerView()
        containerView.previewImageView.image = previewImage
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
//        let previewImageView = UIImageView(image: previewImage)
//        view.addSubview(previewImageView)
//        previewImageView.anchor(
//            top: view.topAnchor,
//            leading: view.leadingAnchor,
//            bottom: view.bottomAnchor,
//            trailing: view.trailingAnchor
//        )
//
//        print("Finish processing photo sample buffer...")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        
        setupCaptureSession()
        setupHUD()
    }
    
    let output = AVCapturePhotoOutput()
    
    private func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch let error {
            print("Could not setup camera input:", error)
        }
        
        
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    private func setupHUD() {
        view.addSubview(capturePhotoButton)
        capturePhotoButton.anchor(
            top: nil,
            leading: nil,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 0, bottom: -24, right: 0),
            size: .init(width: 80, height: 80)
        )
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(dismissButton)
        dismissButton.anchor(
            top: view.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 12, left: 0, bottom: 0, right: -12),
            size: .init(width: 50, height: 50)
        )
    
    }
    
}
