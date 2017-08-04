//
//  HowToUsePageViewController.swift
//  PedScripts
//
//  Created by Victor Yurkin on 8/4/17.
//  Copyright © 2017 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class HowToUsePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let pageViewControllers: [UIViewController] = {
        let pageOne = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowToUsePageOne")
        let pageTwo = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowToUsePageTwo")
        let pageThree = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowToUsePageThree")
        let pageFour = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowToUsePageFour")
        let pageFive = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowToUsePageFive")
        return [pageOne, pageTwo, pageThree, pageFour, pageFive]
    }()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.dataSource = self
        setViewControllers([pageViewControllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.index(of: viewController)!
        
        if index - 1 >= 0 {
            return pageViewControllers[index - 1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.index(of: viewController)!
        
        if index + 1 < pageViewControllers.count {
            return pageViewControllers[index + 1]
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
