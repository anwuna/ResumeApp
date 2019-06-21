//
//  LoadingView.swift
//  ResumeApp
//
//  Created by Chibundu Anwuna on 2019-06-20.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import UIKit

class LoadingView {
    private var subView: UIView!
    private var activityIndicator: UIActivityIndicatorView!

    static let shared = LoadingView()
    
    func startAnimating(in view: UIView){
        subView = createLoadingView(in: view)
        view.addSubview(subView)
        view.addConstraints([
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subView.topAnchor.constraint(equalTo: view.topAnchor),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator?.stopAnimating()
        subView?.removeFromSuperview()
    }
    
    private func createLoadingView(in view: UIView) -> UIView{
        let loadingView = UIView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))
        self.activityIndicator = UIActivityIndicatorView()
        
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        loadingView.clipsToBounds = true
        loadingView.layer.zPosition = 1
        activityIndicator.style = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)
        
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        
        return loadingView
    }
}
