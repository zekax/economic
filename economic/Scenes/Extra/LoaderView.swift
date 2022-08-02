//
//  LoaderView.swift
//  economic
//
//  Created by José Rodrigues on 02/08/2022.
//

import Foundation
import UIKit

class LoaderView: UIView {
    
    var activityIndicator:UIActivityIndicatorView!
    
    init(background: Bool, frame: CGRect, bgColor: UIColor = UIColor(named: "Foreground") ?? .darkGray){
        super.init(frame: frame)
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.isHidden = false
        
        activityIndicator.center = CGPoint(x: self.bounds.size.width  / 2,
                                           y: self.bounds.size.height / 2)
        self.addSubview(activityIndicator)
        if background{
            self.backgroundColor = bgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicator.center = CGPoint(x: self.bounds.midX,
                                           y: self.bounds.midY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.isHidden = false
        
        activityIndicator.center = CGPoint(x: self.bounds.size.width  / 2,
                                           y: self.bounds.size.height / 2)
        self.addSubview(activityIndicator)
    }
    
    func showLoader(){
        self.isHidden = false
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1
        }, completion: nil)
        
        //activityIndicator.play
    }
    
    func hideLoader(){
        self.isHidden = false
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }, completion: nil)
    }

}
