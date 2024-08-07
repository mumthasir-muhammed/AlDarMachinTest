//
//  Utility.swift
//  AlDarMachinTest
//
//  Created by Mumthasir VP on 07/08/24.
//

import Foundation
import UIKit

class Utility {
    static var shared = Utility()
    private init () {}
    
    public static var spinner: UIActivityIndicatorView?
    public static var style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.large
    public static var baseBackColor = UIColor(white: 0, alpha: 0.6)
    public static var baseColor = UIColor.red

    
    public func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        if Utility.spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            Utility.spinner = UIActivityIndicatorView(frame: frame)
            Utility.spinner!.backgroundColor = backColor
            Utility.spinner!.style = style
            Utility.spinner?.color = baseColor
            window.addSubview(Utility.spinner!)
            Utility.spinner!.startAnimating()
        }
    }
    
    public func hideSpinner() {
        if Utility.spinner != nil {
            Utility.spinner!.stopAnimating()
            Utility.spinner!.removeFromSuperview()
            Utility.spinner = nil
        }
    }
    
    public func showSpinner(){
        Utility.shared.start(style: UIActivityIndicatorView.Style.medium, backColor: .clear, baseColor: .gray)
    }
}
