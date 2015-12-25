//
//  BannerView.swift
//  zanadu
//
//  Created by yangying on 15/11/20.
//  Copyright © 2015年 zanadu. All rights reserved.
//
import UIKit
import Haneke
protocol BannerViewTapDelegate{
    //delegateMethod
    func BannerViewTapWithIndex(index:Int)
}
class BannerView: UIView,UIScrollViewDelegate{
    //MARK: - Properties
    var bannerObjects = [NSURL]()
    var pageTintColor = UIColor()
    var currentPageTintColor = UIColor()
    
    var slideShowPageControl = UIPageControl()
    var slideshowView = UIScrollView()
    var bannerTimer = NSTimer()
    var delegate : BannerViewTapDelegate?
    //MARK: - method
    func defaultSettings(){
        self.slideshowView.frame = CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)
        self.slideshowView.contentSize = CGSizeMake(0, self.slideshowView.frame.size.height)
        self.slideshowView.backgroundColor = UIColor.clearColor()
        self.slideshowView.pagingEnabled = true
        self.slideshowView.delegate = self
        self.slideshowView.showsHorizontalScrollIndicator = false
        self.slideshowView.showsVerticalScrollIndicator   = false
        self.slideshowView.userInteractionEnabled         = true
        self.addSubview(self.slideshowView)
        
        //pageControl
        slideShowPageControl.frame = CGRectMake( slideShowPageControl.frame.origin.x, self.frame.size.height - 50, 200, 20)
        slideShowPageControl.center = CGPointMake(self.center.x, slideShowPageControl.center.y)
        slideShowPageControl.pageIndicatorTintColor = self.pageTintColor
        slideShowPageControl.currentPageIndicatorTintColor = self.currentPageTintColor
        slideShowPageControl.userInteractionEnabled = true
        slideShowPageControl.numberOfPages = 0
        slideShowPageControl.currentPage = 0
        self.addSubview(slideShowPageControl)
        self.slideshowView.bringSubviewToFront(slideShowPageControl)
        
        
        // gesture
        let singleTap = UITapGestureRecognizer(target: self, action:"onCoverTapped")
        singleTap.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTap)
        
        
    }
    func setbannerObjects(objects:[NSURL]){
        self.loadTopTimer()
        self.bannerObjects = objects
        self.slideshowView.contentSize = CGSizeMake(self.frame.size.width * CGFloat(objects.count + 2), self.slideshowView.frame.size.height)
        self.slideshowView.contentOffset = CGPointMake(self.frame.size.width, 0)
        self.slideShowPageControl.numberOfPages = objects.count
        for (var i = 0;i < objects.count + 2;i++){
            var j = 0
            if objects.count < 1{
                return
            }
            if i == 0{
                j = objects.count - 1
            }else if i == objects.count + 1{
                j = 0
            }else{
                j = i - 1
            }
            let imageUrl = objects[j]
            let imageV = UIImageView()
            imageV.image = UIImage(named:"defaultImage")
            imageV.contentMode = UIViewContentMode.ScaleAspectFill
            imageV.frame = CGRectMake( CGFloat(i) * self.frame.size.width, 0, self.slideshowView.frame.size.width, self.slideshowView.bounds.size.height)
            imageV.hnk_setImageFromURL(imageUrl)
            slideshowView.addSubview(imageV)
        }

    }
    func bannerTimer(timer:NSTimer){
        var current =  self.slideShowPageControl.currentPage
        current++
        if current == self.bannerObjects.count{
            current = 0
            let transition = CATransition()
            transition.delegate = self
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            slideshowView.exchangeSubviewAtIndex(1, withSubviewAtIndex: 0)
            slideshowView.layer.addAnimation(transition, forKey: "animation")
            slideshowView.contentOffset = CGPointMake(CGFloat( 1 + current) * self.bounds.size.width, 0)
        }else{
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.slideshowView.contentOffset = CGPointMake(CGFloat( 1 + current) * self.bounds.size.width, 0)
            })
        }
        self.slideShowPageControl.currentPage =  current
        
    }
    func setTimerInvalidate(){
        self.bannerTimer.invalidate()
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == slideshowView{
            var page = CGFloat(slideshowView.contentOffset.x)
            if page <= 0{
                slideshowView.setContentOffset(CGPointMake(scrollView.contentSize.width - 2 * self.bounds.size.width, 0), animated: false)
                slideShowPageControl.currentPage = self.bannerObjects.count - 1
            }else if page >= (slideshowView.contentSize.width - self.bounds.size.width){
                slideshowView.setContentOffset(CGPointMake( self.bounds.size.width, 0), animated: false)
                slideShowPageControl.currentPage = 0
            }else{
                page = (scrollView.contentOffset.x / self.bounds.size.width ) - 1
                slideShowPageControl.currentPage = Int(page)
            }
            
        }
    }
    func loadTopTimer(){
        bannerTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("bannerTimer:"), userInfo: nil, repeats: true)
        bannerTimer.fire()
    }
    func onCoverTapped(){
        
        if delegate != nil{
            self.delegate?.BannerViewTapWithIndex(self.slideShowPageControl.currentPage)
          
        }
    }
}
