//
//  WatchViewController.swift
//  tentwenty
//
//  Created by Furqan Ali Khan on 01/04/2022.
//

import UIKit
import SDWebImage

class WatchViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var searchResultCountLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    let dataSource = MoviesCollectionViewSourceAdaptor()
    var viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib3 = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        collectionView.register(nib3, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        let nib1 = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib1, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        searchTextField.delegate = self
        getMoviesApiServiceRequest()
    }
    
  
    
    
    //mark - Event Functions
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        if sender.text == ""{
            showTemplate2()
        }
        else
        {
            self.dataSource.myDataList = (viewModel?.searchInTheData(inputString: sender.text!))!
            self.collectionView.delegate = self.dataSource
            self.collectionView.dataSource = self.dataSource
            self.collectionView.reloadData()
        }
        
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
        SwipeViewLeft(inputView: defaultView, withAnimation: true)
        SwipeViewMid(inputView: searchView, withAnimation: true)
        
        showTemplate2()
    }
    
    @IBAction func searchCancelClicked(_ sender: UIButton) {
        SwipeViewRight(inputView: searchView, withAnimation: true)
        SwipeViewMid(inputView: defaultView, withAnimation: true)
        showTemplate1()
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        SwipeViewLeft(inputView: searchView, withAnimation: true)
        SwipeViewMid(inputView: resultView, withAnimation: true)
    
        searchResultCountLabel.text = (self.viewModel?.searchResultArray.count.string)! + " Results"
        
        return true
    }
    
    @IBAction func searchBackButtonClicked(_ sender: UIButton) {
        SwipeViewRight(inputView: resultView, withAnimation: true)
        SwipeViewMid(inputView: searchView, withAnimation: true)
        showTemplate2()
        searchTextField.text = ""
    }
}



extension WatchViewController{
    //mark - UI Functions
    
    
    func loadDataIntoUI(){
        
        self.dataSource.myDataList = self.viewModel!.dataList
        self.collectionView.delegate = self.dataSource
        self.collectionView.dataSource = self.dataSource
        self.collectionView.reloadData()
    }
    
    func showTemplate3(){
        
        viewModel?.showTemplate3()
        self.dataSource.myDataList = self.viewModel!.dataList
        self.collectionView.delegate = self.dataSource
        self.collectionView.dataSource = self.dataSource
        self.collectionView.reloadData()
    }
    func showTemplate2(){
        
        viewModel?.showTemplate2()
        self.dataSource.myDataList = self.viewModel!.dataList
        self.collectionView.delegate = self.dataSource
        self.collectionView.dataSource = self.dataSource
        self.collectionView.reloadData()
    }
    
    func showTemplate1(){
        viewModel?.showTemplate1()
        self.dataSource.myDataList = self.viewModel!.dataList
        self.collectionView.delegate = self.dataSource
        self.collectionView.dataSource = self.dataSource
        self.collectionView.reloadData()
    }
}

extension WatchViewController{
    //mark - Service Call
    
    func getMoviesApiServiceRequest()
    {
        URLReturnerClass.shared.CallPopup(owner: self)
        
        ServiceAPIManagerClass.getSingletonObject().MakeServiceCall2(url: "https://api.themoviedb.org/3/movie/upcoming?api_key=bd9f8dba0de713e16ca5ffcd64291340" , type: "GET", parameters: nil,  onSuccess: { serviceResponse in
            self.viewModel!.getmatchesListingServiceRequestResponse(inputObject: serviceResponse)
            self.loadDataIntoUI()
            URLReturnerClass.getSingletonObject().HidePopUp()
            
        }, onFailure: { errorResponse in
            URLReturnerClass.getSingletonObject().HidePopUp()
            URLReturnerClass.getSingletonObject().ShowToast(inputMessage:errorResponse.errorMessage ?? "" , inputView: self.view)
        })
    }
    
    
}


extension WatchViewController{
    
    
    //Ui animation Functions
    func SwipeViewLeft(inputView:UIView,withAnimation:Bool)
    {
        if withAnimation == true
        {
            UIView.animate(withDuration: 0.55, delay: 0.0, options: .curveEaseInOut, animations: {
                
                inputView.frame = CGRect.init(x: (self.mainView.frame.width * -1), y: inputView.frame.origin.y, width: inputView.frame.width, height: inputView.frame.height)
                
                self.view.layoutIfNeeded()
                
            }, completion: { finished in
                print("Animation Ended!")
                
            })
        }
        else
        {
            inputView.frame = CGRect.init(x: (self.mainView.frame.width * -1), y: inputView.frame.origin.y, width: inputView.frame.width, height: inputView.frame.height)
            
            self.view.layoutIfNeeded()
        }
    }
    
    func SwipeViewMid(inputView:UIView,withAnimation:Bool)
    {
        if withAnimation == true
        {
            UIView.animate(withDuration: 0.55, delay: 0.0, options: .curveEaseInOut, animations: {
                
                inputView.frame = CGRect.init(x: 8, y: inputView.frame.origin.y, width: inputView.frame.width, height: inputView.frame.height)
                
                self.view.layoutIfNeeded()
                
            }, completion: { finished in
                print("Animation Ended!")
                
            })
        }
        else
        {
            inputView.frame = CGRect.init(x: 0, y: inputView.frame.origin.y, width: inputView.frame.width, height: inputView.frame.height)
            
            self.view.layoutIfNeeded()
        }
    }
    
    func SwipeViewRight(inputView:UIView,withAnimation:Bool)
    {
        if withAnimation == true
        {
            
            UIView.animate(withDuration: 0.55, delay: 0.0, options: .curveEaseInOut, animations: {
                
                inputView.frame = CGRect.init(x: self.mainView.frame.width, y: inputView.frame.origin.y, width: inputView.frame.width, height: inputView.frame.height)
                
                self.view.layoutIfNeeded()
                
            }, completion: { finished in
                print("Animation Ended!")
                
            })
        }
        else
        {
            inputView.frame = CGRect.init(x: UIScreen.main.bounds.width, y: inputView.frame.origin.y, width: inputView.frame.width, height: inputView.frame.height)
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    
}




class MoviesCollectionViewSourceAdaptor : NSObject,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public var myDataList = [MovieClass]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let inset:CGFloat = 0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if myDataList[indexPath.row].templateType == 1 {
            return CGSize(width: collectionView.frame.width, height: 180)
        }
        else if myDataList[indexPath.row].templateType == 2{
            return CGSize(width: ((collectionView.frame.width / 2) - 10), height: 100)
        }
        else {
            return CGSize(width: collectionView.frame.width, height: 120)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if myDataList[indexPath.row].templateType == 1 || myDataList[indexPath.row].templateType == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
            
            cell.nameLabel.text = myDataList[indexPath.row].title
            cell.logoImageView.sd_setImage(with: URL.init(string: myDataList[indexPath.row].poster_path!), completed: { (image, error, cacheType, imageURL) in
                if error != nil
                {
                    cell.logoImageView.image = UIImage()
                }
            })
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
            
            cell.nameLabel.text = myDataList[indexPath.row].title
            cell.categoryLabel.text = myDataList[indexPath.row].title
            cell.logoImageView.sd_setImage(with: URL.init(string: myDataList[indexPath.row].poster_path!), completed: { (image, error, cacheType, imageURL) in
                if error != nil
                {
                    cell.logoImageView.image = UIImage()
                }
            })
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        if myDataList[indexPath.row].templateType == 1{
//            (collectionView.parentViewController as! WatchViewController).template1Selected()
//        }
//        else if myDataList[indexPath.row].templateType == 2{
//            (collectionView.parentViewController as! WatchViewController).template2Selected()
//        }
    }
    
}
