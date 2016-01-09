//
//  ViewController.swift
//  Achievements
//
//  Created by Ivan C Myrvold on 22.12.2015.
//  Copyright © 2015 Ivan C Myrvold. All rights reserved.
//

import UIKit

extension UIView {
    func fadeIn(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.7
            }, completion: completion)	}
    
    func fadeOut(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var achievementLabel: UILabel!
    @IBOutlet weak var achievementLabel2: UILabel!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var coolLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var greenCircleView: UIView!
    @IBOutlet weak var awesomeLabel: UILabel!
    @IBOutlet weak var thanksButton: UIButton!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var yesLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var yesTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var demoLabel: UILabel!
    static var goalState: Notifications.Categories = .NoMessage

    override func viewDidLoad() {
        super.viewDidLoad()
        self.greenCircleView.layer.cornerRadius = self.greenCircleView.frame.size.width/2.0
        self.greenCircleView.backgroundColor = UIColor(red: 181/255.0, green: 1.0, blue: 186/255.0, alpha: 1.0)
        self.thanksButton.layer.cornerRadius = 15
        self.thanksButton.layer.borderWidth = 1.0
        self.thanksButton.layer.borderColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1).CGColor
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "startYourGoal:", name: UIApplicationDidBecomeActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillResign:", name: UIApplicationWillResignActiveNotification, object: nil)
    }

    
    func startYourGoal(notification: NSNotification) {
        if (ViewController.goalState == .MessageGoal) {
            let attrs = [NSFontAttributeName : UIFont.italicSystemFontOfSize(17.0)]
            let attributedString = NSMutableAttributedString(string: "On this beautiful Saturday,")
            let attributedString2 = NSMutableAttributedString(string: "what is the ")
            let italicString = NSMutableAttributedString(string: "one thing", attributes: attrs)
            let attributedStringEnd = NSMutableAttributedString(string: " you want to achieve?")
            
            attributedString2.appendAttributedString(italicString)
            attributedString2.appendAttributedString(attributedStringEnd)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, attributedString.length))
            attributedString2.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, attributedString2.length))
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 10
            style.alignment = .Center
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attributedString.length))
            attributedString2.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attributedString2.length))
            
            achievementLabel.attributedText = attributedString
            achievementLabel2.attributedText = attributedString2
            self.achievementLabel.fadeIn(completion: {
                (finished: Bool) -> Void in
                self.achievementLabel2.fadeIn(completion: {
                    (finished: Bool) -> Void in
                    self.goalTextField.hidden = false
                    
                    let path = UIBezierPath()
                    path.moveToPoint(CGPointMake(20.0, 320.0))
                    path.addLineToPoint(CGPointMake(360.0, 320.0))
                    
                    let shapeLayer = CAShapeLayer()
                    shapeLayer.path = path.CGPath
                    shapeLayer.strokeColor = UIColor.whiteColor().CGColor
                    shapeLayer.lineWidth = 1.0
                    shapeLayer.opacity = 0.5
                    shapeLayer.fillColor = UIColor.clearColor().CGColor
                    shapeLayer.name = "line"
                    
                    self.view.layer.addSublayer(shapeLayer)
                    self.goalTextField.becomeFirstResponder()
                })
            })
        } else if ViewController.goalState == .MessageResult {
            let animation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = 1.0
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            coolLabel.alpha = 1.0
            buttonView.pop_addAnimation(animation, forKey: nil)
        } else if ViewController.goalState == .NoMessage {
            let attrs = [NSFontAttributeName : UIFont.italicSystemFontOfSize(17.0)]
            let italicString = NSMutableAttributedString(string: "How to run this demo: \n\nPress the HOME button to quit the app, and wait for the first interactive notification. Drag down from the top to reveal the two buttons. When you have typed in the goal for today, quit again and wait for the next interactive notification. Have fun!", attributes: attrs)
            
            italicString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSMakeRange(0, italicString.length))
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 10
            style.alignment = .Center
            italicString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, italicString.length))
            
            demoLabel.hidden = false
            demoLabel.attributedText = italicString
        }

    }
    
    func resetEverything() {
        self.achievementLabel.alpha = 0.0
        self.achievementLabel2.alpha = 0.0
        self.goalTextField.hidden = true
        self.goalTextField.text = ""
        self.coolLabel.alpha = 0.0
        self.greenCircleView.hidden = true
        self.greenCircleView.layer.pop_removeAllAnimations()
        self.buttonView.alpha = 0.0
        self.yesView.hidden = false
        self.noView.hidden = false
        self.bubbleView.hidden = true
        self.yesLeadingConstraint.constant = 10.0
        self.yesTopConstraint.constant = 273.0

        if let sublayers = self.view.layer.sublayers {
            for layer in sublayers {
                if let name = layer.name {
                    if name == "line" {
                        layer.removeFromSuperlayer()
                    }
                }
            }
        }
    }
    
    func appWillResign(notification: NSNotification) {
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.timeZone = .localTimeZone()
        notification.alertBody = "Your Achievement Goal!"
        
        if ViewController.goalState == .NoMessage {
            notification.category = Notifications.Categories.MessageGoal.rawValue
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            goalTextField.enabled = true
            self.coolLabel.text = "Cool. come back later and tell us how it went!"
            demoLabel.hidden = true
        } else if ViewController.goalState == .MessageGoal {
            notification.category = Notifications.Categories.MessageResult.rawValue
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            goalTextField.enabled = false
            self.coolLabel.alpha = 0.0
            self.coolLabel.text = "DID YOU ACHIEVE IT?"
        } else if ViewController.goalState == .MessageResult {
            ViewController.goalState = .NoMessage
            self.resetEverything()
       }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        let gradientView = self.view as! GradientView
        let topColor = UIColor(colorLiteralRed: 0x83/256.0, green: 0xa4/256.0, blue: 0xd4/256.0, alpha: 1.0)
        let botColor = UIColor(colorLiteralRed: 0x49/256.0, green: 0xc7/256.0, blue: 0xce/256.0, alpha: 1.0)
        gradientView.gradientWithColors(topColor, botColor)
    }
    
    @IBAction func handleSwipw(sender: UISwipeGestureRecognizer) {
        if ViewController.goalState == .MessageGoal {
            self.resetEverything()
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }

    @IBAction func goalTextEntered(sender: UITextField) {
        self.coolLabel.fadeIn()
    }
    
    @IBAction func yesAction(sender: UIButton) {
        
        let animation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        coolLabel.alpha = 1.0
        buttonView.pop_addAnimation(animation, forKey: nil)
        
//        let snap = self.view.snapshotViewAfterScreenUpdates(false)
        
        // animate yes button to middle of growing green circle
        self.greenCircleView.hidden = false
        self.greenCircleView.superview?.bringSubviewToFront(self.greenCircleView)
        let yesAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        yesAnimation.springSpeed = 20.0
        yesAnimation.springBounciness = 10.0
        yesAnimation.fromValue = 10.0
        yesAnimation.toValue = 100.0
        
        let yesUpAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        yesUpAnimation.springSpeed = 20.0
        yesUpAnimation.springBounciness = 10.0
        yesUpAnimation.fromValue = 273.0
        yesUpAnimation.toValue = 20.0
        
        self.yesLeadingConstraint.pop_addAnimation(yesAnimation, forKey: nil)
        self.yesTopConstraint.pop_addAnimation(yesUpAnimation, forKey: nil)

        // animate green circle to grow
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.toValue = NSValue(CGSize: CGSizeMake(20, 20))
        scaleAnimation.springBounciness = 10.0
        scaleAnimation.completionBlock = {(anim:POPAnimation!, finished:Bool) -> Void in
            self.bubbleView.alpha = 0.0
            self.bubbleView.hidden = false
            self.bubbleView.superview?.bringSubviewToFront(self.bubbleView)
            
            // animate the awesome text and thanks button alpha to 1.0
            let bubanimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            bubanimation.fromValue = 0.0
            bubanimation.toValue = 1.0
            bubanimation.duration = 1.0
            bubanimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            self.bubbleView.pop_addAnimation(animation, forKey: nil)

        }
        // blur effect not working, come back later to investigate
//        let blurEffect = UIBlurEffect(style: .Light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.view.bounds
//        self.view.addSubview(blurEffectView)
//        self.view.addSubview(snap)
        self.yesView.hidden = true
        self.greenCircleView.layer.pop_addAnimation(scaleAnimation, forKey: "scaleAnimation")
    }
    
    @IBAction func thanksButtonAction(sender: UIButton) {
        self.bubbleView.hidden = true

        self.greenCircleView.layer.pop_removeAllAnimations()
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.toValue = NSValue(CGSize: CGSizeMake(0.005, 0.005))
        scaleAnimation.completionBlock = {(anim:POPAnimation!, finished:Bool) -> Void in
            self.greenCircleView.hidden = true
            self.yesView.hidden = false
            self.noView.hidden = true
            // animate yes button from center of green circle
            self.yesLeadingConstraint.constant = 100.0
            let yesTopAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            yesTopAnimation.springSpeed = 20.0
            yesTopAnimation.springBounciness = 10.0
            yesTopAnimation.fromValue = 20.0
            yesTopAnimation.toValue = 273.0
            self.yesTopConstraint.pop_addAnimation(yesTopAnimation, forKey: nil)
        }
        
         self.greenCircleView.layer.pop_addAnimation(scaleAnimation, forKey: "scaleAnimation")
   }
}

