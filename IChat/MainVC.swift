//
//  ViewController.swift
//  IChat
//
//  Created by Mac on 12/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    // IBOutlet variables
    
    @IBOutlet var scrollView: UIScrollView! // scrollView
    @IBOutlet var mainView: MainView! // mainView
    
    //  variables

    var listScrollModel : ListScrollModel! // scrollView model to handle all scrolling functionalities
 
    
// MARK: override UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        listScrollModel = ListScrollModel.init(scrollView: self.scrollView)
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //  load subviews
 
        loadSubViews()
        
    }

    
// MARK: load subViews
   
    func loadSubViews(){
        
        mainView.loadViews()

    }

 
}

