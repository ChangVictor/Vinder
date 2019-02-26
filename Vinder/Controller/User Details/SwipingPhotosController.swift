//
//  SwipingPhotosController.swift
//  Vinder
//
//  Created by Victor Chang on 26/02/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "cillian1"))
//        view.addSubview(imageView)
//        imageView.fillSuperview()
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = .red
        
        let blueController = UIViewController()
        blueController.view.backgroundColor = .blue
        
        let controllers = [
            redViewController,
            blueController
        ]
        
        setViewControllers(controllers, direction: .forward, animated: false, completion: nil)
    }


}
