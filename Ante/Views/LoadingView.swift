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
   @IBOutlet weak var loadingImage: UIImageView!
   
   var isRotating = false
   var rotateAnimation: CABasicAnimation? = nil
   
   convenience init() {
      self.init(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
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
      self.center = self.superview!.center
   }
   
   func beginRefreshing() {
      if (self.isRotating == true) {
         return
      }
      
      self.rotate360Degrees()
   }
   
   func endRefreshing() {
      UIView.animate(withDuration: 0.5) {
         self.loadingImage.alpha = 0.0
      }
      
      UIView.animate(withDuration: 0.5, animations: {
         self.loadingImage.alpha = 0
      }) { (result) in
         self.isRotating = false
         self.rotateAnimation?.speed = 0.00
      }
   }
   
   private func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: CAAnimationDelegate? = nil) {
      rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
      rotateAnimation!.fromValue = 0.0
      rotateAnimation!.toValue = CGFloat(.pi * 2.0)
      rotateAnimation!.duration = duration
      rotateAnimation!.repeatCount = .infinity
      
      if let delegate = completionDelegate {
         rotateAnimation!.delegate = delegate
      }
      
      self.layer.add(rotateAnimation!, forKey: nil)
   }
}
