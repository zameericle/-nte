//
//  LoadingView.swift
//  Ante
//
//  Created by Zameer Andani on 5/13/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
   @IBOutlet var contentView: UIView!
   
   var isRotating = false
   var rotateAnimation: CABasicAnimation? = nil
   
   convenience init(view: UIView) {
      self.init(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
      view.addSubview(self)
      self.contentView.alpha = 0.7
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      commonInit()
   }
   
   func commonInit() {
      Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
      self.addSubview(contentView)
      contentView.frame = self.bounds
      contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      self.alpha = 1.0
      self.center = self.superview!.center
   }
   
   func beginRefreshing() {
      if (self.isRotating == true) {
         return
      }
      
      self.rotate360Degrees()
   }
   
   func endRefreshing() {
      UIView.animate(withDuration: 0.3, animations: {
         self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
         self.alpha = 0
      }) { (result) in
         self.isRotating = false
         self.rotateAnimation?.speed = 0.00
         self.removeFromSuperview()
      }
   }
   
   private func rotate360Degrees(duration: CFTimeInterval = 1.0) {
      rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
      rotateAnimation!.fromValue = 0.0
      rotateAnimation!.toValue = CGFloat(.pi * 2.0)
      rotateAnimation!.duration = duration
      rotateAnimation!.repeatCount = .infinity

      let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
      scaleAnimation.fromValue = 0.0
      scaleAnimation.toValue = 1.0
      scaleAnimation.duration = duration

      self.layer.add(rotateAnimation!, forKey: nil)
      self.layer.add(scaleAnimation, forKey: nil)
   }
}
