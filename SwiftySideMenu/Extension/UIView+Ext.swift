//  MIT License
//
//  Copyright (c) 2021 GIJoeCodes
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  UIView+Ext.swift
//  SwiftyAdminTracker
//
//  Created by GIJoeCodes on 12/2/21.
//

import UIKit

extension UIView {
    
    func setAnchors(
        top: NSLayoutYAxisAnchor?,
        paddingTop: CGFloat,
        right: NSLayoutXAxisAnchor?,
        paddingRight: CGFloat,
        bottom: NSLayoutYAxisAnchor?,
        paddingBottom: CGFloat,
        left: NSLayoutXAxisAnchor?,
        paddingLeft: CGFloat,
        width: CGFloat,
        height: CGFloat
    ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right = right {
            self.trailingAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let left = left {
            self.leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    
    
    func centerView(
        centerXAxis: NSLayoutXAxisAnchor?,
        paddingXAxis: CGFloat,
        centerYAxis: NSLayoutYAxisAnchor?,
        paddingYAxis: CGFloat,
        width: CGFloat,
        height: CGFloat
    ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerXAxis = centerXAxis {
            self.centerXAnchor.constraint(equalTo: centerXAxis, constant: paddingXAxis).isActive = true
        }
        
        if let centerYAxis = centerYAxis {
            self.centerYAnchor.constraint(equalTo: centerYAxis, constant: paddingYAxis).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    func addBackground(image: UIImage, opacity: Float, addBlurEffect: Bool) {
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        let imageView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: width,
                height: height
            )
        )
        imageView.image = image
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.opacity = opacity
        
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
        
        if addBlurEffect {
            let blurEffect = UIBlurEffect(style: .prominent)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = imageView.bounds
            blurEffectView.alpha = 0.75
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            imageView.addSubview(blurEffectView)
        }
        
    }
    
}
