//
//  SwipingPhotosController.swift
//  Vinder
//
//  Created by Victor Chang on 26/02/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource {
    
    let controllers = [
        PhotoController(image: #imageLiteral(resourceName: "hailey1")),
        PhotoController(image: #imageLiteral(resourceName: "logan1")),
        PhotoController(image: #imageLiteral(resourceName: "dua2")),
        PhotoController(image: #imageLiteral(resourceName: "cillian1"))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        view.backgroundColor = .white
        
        setViewControllers([controllers.first!], direction: .forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == 0 { return nil }
        return controllers[index - 1 ]
    }
    
}


    


class PhotoController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "logan1"))

    init(image: UIImage) {
        imageView.image = image
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFit
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
