//
//  CallViewController.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation
import UIKit

class CallViewController: UIViewController {

    private let rootView = CallView()
    
    private let viewModel: CallViewModel
    
    private lazy var hangupButton: UIBarButtonItem = {
        return UIBarButtonItem(title: nil,
                               style: .plain,
                               target: self,
                               action: #selector(hangupButtonButtonPressed))
        
    }()

    init(viewModel: CallViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupBindings()
        
        self.viewModel.input.ready?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.showBackArrowOnly()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}

private extension CallViewController {
    
    func setupUI() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.setRightBarButtonItems([self.hangupButton], animated: true)
    }
    
    func setupBindings() {
        self.viewModel.output.titleMain = Self.bindOnMain { [weak self] name in
            self?.navigationItem.title = name
        }
        
        self.viewModel.output.error = Self.bindOnMain { [weak self] error in
            self?.showErrorAlert(title: nil, message: error)
        }
        
        self.viewModel.output.isLoading = Self.bindOnMain { [weak self] isLoading in
            if isLoading {
                self?.rootView.startLoader()
            } else {
                self?.rootView.stopLoader()
            }
        }
        
        self.viewModel.output.hangupTitle = Self.bindOnMain { [weak self] title in
            self?.hangupButton.title = title
        }
        
        self.viewModel.output.addOddFeed = Self.bindOnMain { [weak self] feed in
            self?.rootView.addOddFeed(videoStream: feed.videoStream, videoId:feed.videoId)
        }
        
        self.viewModel.output.addEvenFeed = Self.bindOnMain { [weak self] feed in
            self?.rootView.addEvenFeed(videoStream: feed.videoStream, videoId:feed.videoId)
        }
        
        self.viewModel.output.removeFeed = Self.bindOnMain { [weak self] feed in
            self?.rootView.removeFeed(videoStream: feed.videoStream, videoId: feed.videoId)
        }
    }
}

private extension CallViewController {
    @objc func hangupButtonButtonPressed() {
        self.viewModel.input.hangupSelected?()
    }
}
