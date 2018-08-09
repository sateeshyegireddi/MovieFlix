//
//  Functions.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class Functions: NSObject
{
    func showSimpleAlert(OnViewController vc: UIViewController, Message message: String) {
        
        //Create alertController object with specific message
        let alertController = UIAlertController(title: GlobalConstants.Constants.appName, message: message, preferredStyle: .alert)
        
        //Add OK button to alert and dismiss it on action
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        
        //Show alert to user
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func addBackgroundGradientWithColours(_ colours: [CGColor], location:[NSNumber], inView: UIView, isHorizontal: Bool)  {
        
        //Create gradient layer with frame and colours
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        gradientLayer.colors = colours
        gradientLayer.locations = location
        
        if isHorizontal {
            gradientLayer.startPoint = CGPoint(x: 0.45, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        inView.layer.addSublayer(gradientLayer)
    }
    
    func parseDouble(in dict: [String: Any]?, for key: String) -> Double {
        
        var double = 0.00
        
        if let value = dict?[key] as? String {
            double = Double(value) ?? 0
        } else if let value = dict?[key] as? Int {
            double = Double(value)
        } else if let value = dict?[key] as? Double {
            double = value
        }
        
        return double
    }
    
    func parseInt(in dict: [String: Any]?, for key: String) -> Int {
        
        var int = 0
        
        if let value = dict?[key] as? String {
            int = Int(value) ?? 0
        } else if let value = dict?[key] as? Int {
            int = Int(value)
        }
        
        return int
    }
    
    func parseString(in dict: [String: Any]?, for key: String) -> String {
        
        var str = ""
        
        if let value = dict?[key] as? String {
            str = value
        } else if let value = dict?[key] as? Int {
            str = String(value)
        }
        
        return str
    }
}
