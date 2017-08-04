//
//  HowToUseViewController.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/2/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class HowToUseViewController: UIViewController, UIPageViewControllerDelegate {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    fileprivate var embeddedViewController: HowToUsePageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update button view
        self.startButton.layer.borderWidth = 1.0
        self.startButton.layer.cornerRadius = 6.0
        self.startButton.layer.borderColor = UIHelper.answerColor.cgColor
        self.startButton.setTitleColor(UIHelper.answerColor, for: .normal)
        
        guard let viewController = self.childViewControllers.first as? HowToUsePageViewController else  {
            fatalError("Check storyboard for missing LocationTableViewController")
        }
        self.embeddedViewController = viewController
        self.embeddedViewController.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAction(_ sender: Any) {
        var currentIndex = self.pageControl.currentPage
        if currentIndex < 4 {
            currentIndex = currentIndex + 1
            self.embeddedViewController.setViewControllers([self.embeddedViewController.pageViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
            self.pageControl.currentPage = currentIndex
            if currentIndex < 4 {
                self.startButton.setTitle("Next", for: .normal)
            }else {
                self.startButton.setTitle("Get Started", for: .normal)
            }
        }else {
            self.startButton.setTitle("Next", for: .normal)
            self.embeddedViewController.setViewControllers([self.embeddedViewController.pageViewControllers[0]], direction: .forward, animated: false, completion: nil)
            self.pageControl.currentPage = 0
            self.performSegue(withIdentifier: "unwindToScripts", sender: self)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let currentIndex = pendingViewControllers.first?.view.tag {
            // update control
            self.pageControl.currentPage = currentIndex
            if currentIndex < 4 {
                self.startButton.setTitle("Next", for: .normal)
            }else {
                self.startButton.setTitle("Get Started", for: .normal)
            }
        }
    }
    
}
