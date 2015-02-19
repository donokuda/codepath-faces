//
//  FacesViewController.swift
//  faces
//
//  Created by Don Okuda on 2/18/15.
//
//

import UIKit

class FacesViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var trayView: UIView!
    var startingTrayCenter: CGPoint!
    var newlyCreatedSmiley: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didPanTraySmiley(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            var imageView = sender.view as UIImageView
            newlyCreatedSmiley = UIImageView(image: imageView.image)
            newlyCreatedSmiley.center = imageView.center
            view.addSubview(newlyCreatedSmiley)
            
            newlyCreatedSmiley.userInteractionEnabled = true
            
            var panGesture = UIPanGestureRecognizer(target: self, action: "didPanSmiley:")
            var pinchGesture = UIPinchGestureRecognizer(target: self, action: "didPinchSmiley:")
            var rotateGesture = UIRotationGestureRecognizer(target: self, action: "didRotateSmiley:")
            
            pinchGesture.delegate = self
            rotateGesture.delegate = self
            
            
            newlyCreatedSmiley.addGestureRecognizer(rotateGesture)
            newlyCreatedSmiley.addGestureRecognizer(pinchGesture)
            newlyCreatedSmiley.addGestureRecognizer(panGesture)
            newlyCreatedSmiley.transform = CGAffineTransformMakeScale(1.5, 1.5)
            
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            newlyCreatedSmiley.center = location
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            
            newlyCreatedSmiley.transform = CGAffineTransformMakeScale(1, 1)
            
        }
    }

    @IBAction func didPanTray(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        if (sender.state == UIGestureRecognizerState.Began) {
            startingTrayCenter = trayView.center
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            trayView.center = CGPoint(x: trayView.center.x, y: startingTrayCenter.y + translation.y)
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            
        }
    }
    
    func didPinchSmiley(sender: UIPinchGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Began) {
            
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            sender.view!.transform = CGAffineTransformMakeScale(sender.scale,sender.scale)
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            
        }
    }
    
    func didPanSmiley(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        if (sender.state == UIGestureRecognizerState.Began) {
            sender.view!.transform = CGAffineTransformScale(sender.view!.transform, 1.5, 1.5)
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            sender.view!.center = location
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            sender.view!.transform = CGAffineTransformScale(sender.view!.transform, 1 / 1.5, 1 / 1.5)
        }
    }
    
    func didRotateSmiley(sender: UIRotationGestureRecognizer) {
        sender.view!.transform = CGAffineTransformRotate(sender.view!.transform, sender.rotation)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
