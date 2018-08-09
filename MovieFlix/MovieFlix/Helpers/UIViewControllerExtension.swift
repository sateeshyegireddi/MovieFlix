//
//  UIViewControllerExtension.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showActivityIndicator() {
        
        //Create and add Activity Indicator View
        let activityIndicatorView = UIView(frame: view.bounds)
        activityIndicatorView.accessibilityIdentifier = "ActivityIndicatorView"
        activityIndicatorView.backgroundColor = UIColor.clear
        view.addSubview(activityIndicatorView)
        
        //Create and add Blur Effect view to super view
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(frame: view.bounds)
        blurEffectView.effect = blurEffect
        blurEffectView.alpha = 0.75
        
        //Create Vibrancy Effect view
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(frame: view.bounds)
        vibrancyEffectView.effect = vibrancyEffect
        
        //Add Vibrancy Effect view to Blur Effect view
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        activityIndicatorView.addSubview(blurEffectView)
        
        //Create and add Activity Indicator to base view
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = GlobalConstants.Colors.teal
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicatorView.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator() {
        
        //Remove the activity indicator
        DispatchQueue.main.async {
            
            for view in self.view.subviews {
                if view.accessibilityIdentifier == "ActivityIndicatorView" {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
