//
//  HomePageViewController.swift
//
//  Created by Furqan Ali Khan on 28/10/2020.
//

import UIKit

class HomePageViewController: UIViewController {

    
    @IBOutlet weak var screen1View: UIView!
    @IBOutlet weak var screen2View: UIView!
    @IBOutlet weak var screen3View: UIView!
    @IBOutlet weak var screen4View: UIView!
    @IBOutlet weak var tab1View: UIView!
    @IBOutlet weak var tab2View: UIView!
    @IBOutlet weak var tab3View: UIView!
    @IBOutlet weak var tab4View: UIView!
    
    
    let firstVC = WatchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstVC.view.frame = screen2View.bounds
        addChild(firstVC)
        screen2View.addSubview(firstVC.view)
        firstVC.didMove(toParent: self)
        
        
        tabChanged(tabView: tab1View, screenView: screen1View)
    }
    
    
    //mark - Event Functions
    
    
    
    @IBAction func tab1Clicked(_ sender: UIButton) {
        tabChanged(tabView: tab1View, screenView: screen1View)
    }
    @IBAction func tab2Clicked(_ sender: UIButton) {
        tabChanged(tabView: tab2View, screenView: screen2View)
    }
    @IBAction func tab3Clicked(_ sender: UIButton) {
        tabChanged(tabView: tab3View, screenView: screen3View)
    }
    @IBAction func tab4Clicked(_ sender: UIButton) {
        tabChanged(tabView: tab4View, screenView: screen4View)
    }
    
    
    //mark - User Definded Functions
    
    func tabChanged(tabView:UIView, screenView: UIView)
    {
        resetTabUI(inputView: tab1View, screenView: screen1View)
        resetTabUI(inputView: tab2View, screenView: screen2View)
        resetTabUI(inputView: tab3View, screenView: screen3View)
        resetTabUI(inputView: tab4View, screenView: screen4View)
        
        setTabUI(inputView: tabView, screenView: screenView)
    }
    
    func resetTabUI(inputView:UIView, screenView:UIView){
        (inputView.viewWithTag(20) as! UILabel).textColor = UIColor.init(r: 111, g: 105, b: 117)
        (inputView.viewWithTag(10) as! UIImageView).tintColor = UIColor.init(r: 111, g: 105, b: 117)
        
        screenView.isHidden = true
    }
    
    func setTabUI(inputView:UIView, screenView:UIView){
        (inputView.viewWithTag(20) as! UILabel).textColor = UIColor.white
        (inputView.viewWithTag(10) as! UIImageView).tintColor = UIColor.white
        screenView.isHidden = false
    }
    

}
