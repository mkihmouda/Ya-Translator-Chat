//
//  ListScrollModel.swift
//  YaTranslator
//
//  Created by Mac on 12/2/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit


class ListScrollModel{
    
    var scrollView : UIScrollView! // scroll view
    var scrollViewAccumulativeHeight : CGFloat = 0.0 // Acc. Height
    var mainVC : MainVC! // parent VC

    
    
    
    init(scrollView : UIScrollView) {
        
        self.scrollView = scrollView
        scrollViewAccumulativeHeight = scrollViewPaddingHeight // inital padding
        
        getRootViewController() // root VC from AppDelegate Widnow
        
    }
    
// MARK: Root View Controller
    
    func getRootViewController(){
        
       let appDelegate  = UIApplication.shared.delegate as! AppDelegate
           mainVC = appDelegate.window?.rootViewController as! MainVC!
        
    }
    
// MARK: add Sender and Receiver to list Scroll
    
    
    func addMessage(view : UIView, keyboardHeigh : CGFloat){
        
 
        view.frame.origin = CGPoint(x: 0 , y: scrollViewAccumulativeHeight)
        self.scrollView.addSubview(view)
  
   
         scrollViewAccumulativeHeight = scrollViewAccumulativeHeight + view.frame.size.height + 5 // update Acc. height
         self.updateScrollContentHeight(keyboardHeigh : keyboardHeigh)
        
        
     }
 
// MARK: update after keyboard shown and hidden
    
    
    func updateScrollWithShownKeyboard(keyboardHeigh : CGFloat){
 
        
            UIView.animate(withDuration: 1.7 , delay: 0.0, options: [.curveEaseOut], animations: {
                
                self.scrollView.frame.size.height = screenHeight - self.scrollView.frame.size.height + keyboardHeigh - 70
                self.scrollView.contentSize.height = self.scrollView.frame.size.height > self.scrollViewAccumulativeHeight ? self.scrollView.frame.size.height :  self.scrollViewAccumulativeHeight
                self.scrollView.contentOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
                

            }, completion: nil)
        
    }
    
    
    func updateScrollWithHiddenKeyboard(keyboardHeigh : CGFloat){
        
  
        UIView.animate(withDuration: 1.7 , delay: 0.0, options: [.curveEaseOut], animations: {
            
            self.scrollView.frame.size.height = screenHeight - 90
            self.scrollView.contentSize.height = self.scrollViewAccumulativeHeight
 
        }, completion: nil)
       
        
    }
    
    
// MARK: update Scroll view data
    
    
    func updateScrollContentHeight(keyboardHeigh : CGFloat){


        if (scrollViewAccumulativeHeight >  scrollView.contentSize.height){
            
            // update content size
         
            scrollView.contentSize.height = scrollViewAccumulativeHeight
            
            UIView.animate(withDuration: 0.7 , delay: 0.0, options: [.curveEaseOut], animations: {
                
                // scroll to bottom 
                
                self.scrollView.contentOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)

            }, completion: nil)
        }
    }
 
    

}
