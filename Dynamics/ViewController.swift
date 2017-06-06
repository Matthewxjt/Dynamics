//
//  ViewController.swift
//  Dynamics
//
//  Created by Matthew Jacome on 6/5/17.
//  Copyright © 2017 matthew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    // MARK: - Properties
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var firstContact = false
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Square
        let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = .gray
        view.addSubview(square)
        
        // Barriers
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = .red
        view.addSubview(barrier)
        
        let barrierTwo = UIView(frame: CGRect(x: 300, y: 400, width: 130, height: 20))
        barrierTwo.backgroundColor = .red
        view.addSubview(barrierTwo)
        
        // Animation and Gravity
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
        
        // Collision behavior
        collision = UICollisionBehavior(items: [square])
        collision.collisionDelegate = self
        // add a boundry that has the same frame as the barrier
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.addBoundary(withIdentifier: "barrierTwo" as NSCopying, for: UIBezierPath(rect: barrierTwo.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let itemBehavior = UIDynamicItemBehavior(items: [square])
        itemBehavior.elasticity = 0.6
        animator.addBehavior(itemBehavior)
        
        var updateCount = 0
        collision.action = {
            if (updateCount % 3 == 0) {
                let outline = UIView(frame: square.bounds)
                outline.transform = square.transform
                outline.center = square.center
                
                outline.alpha = 0.5
                outline.backgroundColor = .clear
                outline.layer.borderColor = square.layer.presentation()?.backgroundColor
                outline.layer.borderWidth = 1.0
                self.view.addSubview(outline)
            }
            
            updateCount += 1
        }
        
    }
    
    // MARK: - Functions
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("Boundary contact occurred - \(String(describing: identifier))")
        let collidingView = item as! UIView
        collidingView.backgroundColor = .yellow
        UIView.animate(withDuration: 0.3) {
            collidingView.backgroundColor = .gray
        }
        if (!firstContact) {
            firstContact = true
            
            let square = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
            square.backgroundColor = .gray
            view.addSubview(square)
            
            collision.addItem(square)
            gravity.addItem(square)
            
            let attach = UIAttachmentBehavior(item: collidingView, attachedTo:square)
            animator.addBehavior(attach)
        }
    }
}

