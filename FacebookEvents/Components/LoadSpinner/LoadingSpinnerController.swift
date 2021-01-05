//
//  LoadingSpinnerViewController.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/9/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import UIKit

class LoadingSpinnerController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(named: "secondaryColor")
        view.addSubview(spinner)
        spinner.color = .white
        self.setSpinnerConstraints()
        self.startSpinner()
    }

    func setSpinnerConstraints() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
    }
    
    func startSpinner() {
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.startAnimating()
    }
}
