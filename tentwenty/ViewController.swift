//
//  ViewController.swift
//  UAP
//
//  Created by Furqan Ali Khan on 28/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        
        
        
        self.navigationController!.pushViewController(HomePageViewController(nibName: "HomePageViewController", bundle: nil), animated: true)
        
    }
    
    
}

