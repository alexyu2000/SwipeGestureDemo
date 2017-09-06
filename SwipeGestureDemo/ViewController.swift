//
//  ViewController.swift
//  SwipeGestureDemo
//
//  Created by Alex Yu on 26/4/2017.
//  Copyright © 2017 Alex Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "flower")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        let directions: [UISwipeGestureRecognizerDirection] = [.up, .down, .right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
            gesture.direction = direction
            self.view?.addGestureRecognizer(gesture)
        }
        setupViews()
    }

    func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.down, UISwipeGestureRecognizerDirection.right:
            print("right swipe or down swipe")
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let scale = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
                let trasform = scale.concatenating(CGAffineTransform.init(translationX: self.ImageView.bounds.width * 0.8, y: self.ImageView.bounds.height * 0.8))
                self.ImageView.transform = trasform
                self.ImageView.alpha = 0.5
            }, completion: nil)
        case UISwipeGestureRecognizerDirection.up, UISwipeGestureRecognizerDirection.left:
            print("up swipe or left swipe")
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let scale = CGAffineTransform.init(scaleX: 1, y: 1)
                let trasform = scale.concatenating(CGAffineTransform.init(translationX: -self.ImageView.bounds.width * 0.5, y: -self.ImageView.bounds.height * 0.5))
                self.ImageView.transform = trasform
                self.ImageView.alpha = 1
            }, completion: nil)
            
        default: break
        }
    }
    
    func setupViews() {
        self.view.addSubview(ImageView)
        self.view.addConstraintsWithFormat("H:|-80-[v0]-80-|", views: ImageView)
        self.view.addConstraintsWithFormat("V:|-80-[v0]-80-|", views: ImageView)
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
