//
//  CallView.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation
import UIKit
import Kingfisher

class CallView: UIView {
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
   
    private lazy var stackHorizontalContainerView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = Resources.Layout.Call.verticalPadding
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var previewContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorFFFFFF
        return view
    }()
    
    private lazy var previewView: CameraView = {
        let view = CameraView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.color000000
        return view
    }()
    
    private lazy var loaderView: UIActivityIndicatorView = {
        let view: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            view = UIActivityIndicatorView(style: .medium)
        } else {
            view = UIActivityIndicatorView(style: .gray)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.color000000.withAlphaComponent(0.3)
        view.color = Resources.UI.Colors.colorFFFFFF
        view.stopAnimating()
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = Resources.UI.Colors.colorC8C8C8
        
        self.addSubview(self.containerView)
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.containerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.containerView.addSubview(self.stackHorizontalContainerView)
        NSLayoutConstraint.activate([
            self.stackHorizontalContainerView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Resources.Layout.Call.horizontalInsets),
            self.stackHorizontalContainerView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: Resources.Layout.Call.verticalInsets),
            self.stackHorizontalContainerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Resources.Layout.Call.horizontalInsets),
            self.stackHorizontalContainerView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -Resources.Layout.Call.verticalInsets)
        ])
        
        self.containerView.addSubview(self.previewContainerView)
        NSLayoutConstraint.activate([
            self.previewContainerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Resources.Layout.Call.Preview.horizontalInsets),
            self.previewContainerView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -Resources.Layout.Call.Preview.verticalsInsets),
            self.previewContainerView.widthAnchor.constraint(equalTo: self.previewContainerView.heightAnchor, multiplier: Resources.Layout.Call.Preview.aspectRatio),
            self.previewContainerView.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: Resources.Layout.Call.Preview.widthContainerRatio)
        ])
        
        self.previewContainerView.addSubview(self.previewView)
        NSLayoutConstraint.activate([
            self.previewView.leadingAnchor.constraint(equalTo: self.previewContainerView.leadingAnchor, constant: Resources.Layout.Call.Preview.padding),
            self.previewView.topAnchor.constraint(equalTo: self.previewContainerView.topAnchor, constant: Resources.Layout.Call.Preview.padding),
            self.previewView.trailingAnchor.constraint(equalTo: self.previewContainerView.trailingAnchor, constant: -Resources.Layout.Call.Preview.padding),
            self.previewView.bottomAnchor.constraint(equalTo: self.previewContainerView.bottomAnchor, constant: -Resources.Layout.Call.Preview.padding)
        ])
        
        self.containerView.addSubview(self.loaderView)
        NSLayoutConstraint.activate([
            self.loaderView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.loaderView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.loaderView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.loaderView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
        ])
    }
}

private extension CallView {
    func createStackVerticalContainerView() -> UIStackView {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = Resources.Layout.Call.verticalPadding
        view.backgroundColor = .clear
        return view
    }
    
    func createVideoStream(videoStream: URL, videoId: Int) -> UIImageView {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.color000000
        view.kf.setImage(with: videoStream)
        view.contentMode = .scaleAspectFit
        view.tag = videoId
        return view
    }
}

extension CallView {
    func addOddFeed(videoStream: URL, videoId: Int) {
        let stack = self.createStackVerticalContainerView()
        let stream = self.createVideoStream(videoStream: videoStream, videoId: videoId)
        stack.addArrangedSubview(stream)
        self.stackHorizontalContainerView.addArrangedSubview(stack)
        
        self.setNeedsLayout()
    }
    
    func addEvenFeed(videoStream: URL, videoId: Int) {
        let stream = self.createVideoStream(videoStream: videoStream, videoId: videoId)
        if let stack = self.stackHorizontalContainerView.arrangedSubviews.last as? UIStackView {
            stack.addArrangedSubview(stream)
        }
        
        self.setNeedsLayout()
    }
    
    func removeFeed(videoStream: URL, videoId: Int) {
        guard let streamView = self.stackHorizontalContainerView.viewWithTag(videoId) else { return }
        guard let verticalContainerStackView = streamView.superview as? UIStackView else { return }
        verticalContainerStackView.removeArrangedSubview(streamView, shouldRemoveFromSuperview: true)
        if verticalContainerStackView.arrangedSubviews.isEmpty {
            self.stackHorizontalContainerView.removeArrangedSubview(verticalContainerStackView, shouldRemoveFromSuperview: true)
        }
        
        self.setNeedsLayout()
    }
    
    func showControlPanel() {
        // TODO
    }
    
    func hideControlPanel() {
        // TODO
    }
    
    func startLoader() {
        self.loaderView.startAnimating()
        self.loaderView.isHidden = false
    }

    func stopLoader() {
        self.loaderView.stopAnimating()
        self.loaderView.isHidden = true
    }
}
