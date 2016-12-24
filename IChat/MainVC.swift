//
//  ViewController.swift
//  IChat
//
//  Created by Mac on 12/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class MainVC: UIViewController {


    @IBOutlet var scrollView: UIScrollView! // scrollView
    @IBOutlet var mainView: MainView!
    
    
     var listScrollModel : ListScrollModel! // scrollView model to handle scroll issues
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        listScrollModel = ListScrollModel.init(scrollView: self.scrollView)
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadSubViews()
        
    }
    
    func loadSubViews(){
        
        mainView.loadViews()
    
     
    }

 
}

