//
//  ViewController.swift
//  Dynamics
//
//  Created by Matthew Jacome on 6/5/17.
//  Copyright © 2017 matthew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Square object
        let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = .gray
        view.addSubview(square)
        
        // Animation and Gravity
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
    }
}

