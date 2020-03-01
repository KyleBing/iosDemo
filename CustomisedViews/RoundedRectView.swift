//
//  RoundedRectView.swift
//  CustomisedViews
//
//  Created by Kyle on 2017/5/29.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedRectView: UIView {
    
    // MARK: - Configs
    
    @IBInspectable
    var radius: CGFloat = 10 { didSet{ setNeedsDisplay() } }
    
    @IBInspectable
    var lineWidth: CGFloat = 1 / UIScreen.main.scale {
        didSet{
            lineWidth = lineWidth / UIScreen.main.scale
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var lineColor: UIColor = UIColor.lightGray { didSet{ setNeedsDisplay() } }
    
    @IBInspectable
    var fillColor: UIColor = UIColor.white { didSet{ setNeedsDisplay() } }
    
    
    

    //MARK: - Draw()
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let contentRect = self.bounds.insetBy(dx: 20+1/UIScreen.main.scale, dy: 20+1/UIScreen.main.scale)
        let path = UIBezierPath(roundedRect: contentRect, cornerRadius: radius)
        
        context?.saveGState()
        context?.setShadow(offset: CGSize(width: 2, height: 8), blur: CGFloat(15.0), color: UIColor.black.withAlphaComponent(0.2).cgColor)
        
        fillColor.setFill()
        path.fill()
        
        context?.restoreGState()
        path.lineWidth = lineWidth
        let pathOutline = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 20+1/UIScreen.main.scale, dy: 20+1/UIScreen.main.scale), cornerRadius: radius)
        UIColor.white.setFill()
        UIColor.lightGray.setStroke()

        pathOutline.fill()
        pathOutline.stroke()
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
    }
 

}
