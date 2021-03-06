//
//  SummerSlider.swift
//  SummerSliderSample
//
//  Created by derrick on 30/08/2017.
//  Copyright © 2017 Sensation. All rights reserved.
//

import UIKit

class SummerSlider: UISlider {

	var markColor : UIColor!
	var markWidth : CGFloat!
	var markPositions : Array<Float>!
	var selectedBarColor : UIColor!
	var unselectedBarColor : UIColor!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setupDefaultValues()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		fatalError("init(coder:) has not been implemented")
   // self.setupDefaultValues()
	}
 
	override func draw(_ rect: CGRect) {
		super.draw(rect)
    
    // Basic Setup to make a Inner Rect.
		let innerRect = rect.insetBy(dx: Constants.INNER_RECT.X, dy: Constants.INNER_RECT.Y)
		UIGraphicsBeginImageContextWithOptions(innerRect.size ,false , 0)
		let context = UIGraphicsGetCurrentContext()!
    
    // Draw Selection Rect.
    SummerSlider.drawRect(context,  innerRect , self.selectedBarColor.cgColor)
		
    // Make Selection Image.
		let selectedSide = UIGraphicsGetImageFromCurrentImageContext()
		selectedSide!.resizableImage(withCapInsets: UIEdgeInsets.zero)
		
    // Draw UNSelection Rect.
    SummerSlider.drawRect(context,  innerRect , self.unselectedBarColor.cgColor)
		
    // Make UNSelection Image.
		let unSelectedSide = UIGraphicsGetImageFromCurrentImageContext()
		unSelectedSide!.resizableImage(withCapInsets: UIEdgeInsets.zero)
		
    // Draw Selection Image.
		selectedSide!.draw(at: CGPoint(x:0,y:0))
		
    // Draw Selection Marks.
		SummerSlider.drawMarks(context, innerRect, self.markColor.cgColor, self.markPositions, self.markWidth)


		let selectedStripSide = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
		
    // Draw UNSelection Image.
		unSelectedSide!.draw(at: CGPoint(x:0,y:0))
    

    SummerSlider.drawMarks(context, innerRect, self.markColor.cgColor, self.markPositions, self.markWidth)

		
		let unselectedStripSide = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
		
		UIGraphicsEndImageContext()
		
		setupTrackRange(selectedStripSide, unselectedStripSide)
	}
  
  
  private func setupTrackRange(_ selectedStripSide:UIImage , _ unselectedStripSide:UIImage) {
    self.setMinimumTrackImage(selectedStripSide, for: UIControlState.normal)
		self.setMaximumTrackImage(unselectedStripSide, for: UIControlState.normal)
  }
  
  private func setupDefaultValues(){
    self.markColor = UIColor.white
    self.markWidth = 1.0
    self.selectedBarColor = UIColor.white
    self.unselectedBarColor = UIColor.black
    self.markPositions = Array<Float>()
  }
  
  
  private static func drawMarks(_ context:CGContext ,_ innerRect : CGRect , _ markColor:CGColor ,_ marks:Array<Float>! ,_ markWidth:CGFloat) {
    
    for mark in marks {
      context.setLineWidth(markWidth)
      let markWidth = CGFloat(mark)
      let postion:CGFloat! =  CGFloat((innerRect.width  * markWidth ) / Constants.SLIDER.WHOLE_PERCENT)
      context.move(to: CGPoint(x: postion, y: innerRect.height / 2 - 5))
      context.addLine(to: CGPoint(x: postion, y: innerRect.height / 2 + 5))
      context.setStrokeColor(markColor)
      context.strokePath()
    }
  }
  
  private static func drawRect(_ context:CGContext ,_ innerRect : CGRect , _ rectColr:CGColor) {
    context.setLineCap(CGLineCap.round);
    context.setLineWidth(12.0)
    context.move(to: CGPoint(x: 6, y: innerRect.height / 2))
    context.addLine(to: CGPoint(x: innerRect.width - 10, y: innerRect.height / 2))
    context.setStrokeColor(rectColr)
    context.strokePath()
  }

}
