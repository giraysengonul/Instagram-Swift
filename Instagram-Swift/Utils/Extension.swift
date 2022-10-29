//
//  Extension.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 17.08.2022.
//

import UIKit
import JGProgressHUD

extension UIViewController{
    static let hud = JGProgressHUD(style: .dark)
    
    func configureGradientLayer()  {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0,1]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
    }
    func showLoader(_ show: Bool){
        view.endEditing(true)
        if show{
            UIViewController.hud.show(in: view,animated: true)
        }else{
            UIViewController.hud.dismiss(animated: true)
        }
    }
}
extension UIButton{
    
    func attributedTitle(withFirstPart firstPart: String, withSecondPart secondPart: String) {
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        let boldAttributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart)", attributes: attributes)
        attributedTitle.append(NSAttributedString(string: " \(secondPart)", attributes: boldAttributes))
        setAttributedTitle(attributedTitle, for: .normal)
        
    }
    
    func loginAndRegisterButton(withSetTitle setTitleGet: String){
        setTitle(setTitleGet, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = .systemPurple.withAlphaComponent(0.5)
        layer.cornerRadius = 7
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    }
    
    
}
