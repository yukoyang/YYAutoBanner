# YYAutoBanner
This is a banner View that can help you easily add  in your swift project, it  can auto carousel or just by hand.just need Seldom sentences
just like:

 
       {
       let url1 = NSURL(string: "http://img5q.duitang.com/uploads/item/201501/27/20150127163843_BQyf3.jpeg")
        let url2 = NSURL(string: "http://img5.duitang.com/uploads/item/201501/27/20150127164025_BzEm8.jpeg")
        let url3 = NSURL(string: "http://bizhi.33lc.com/uploadfile/2015/0130/20150130023019720.jpg")
        let url4 = NSURL(string: "http://bizhi.33lc.com/uploadfile/2015/0130/20150130023017376.jpg")
        urls = [url1!,url2!,url3!,url4!]
        
        
        bannerV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(bannerV)
        bannerV.pageTintColor = UIColor.lightGrayColor()
        bannerV.currentPageTintColor = UIColor(red: 0.93, green: 0.31, blue: 0.49, alpha: 1)
        bannerV.defaultSettings()
        bannerV.delegate = self
        bannerV.setbannerObjects(urls)
        }
        
        //release delegate
        func BannerViewTapWithIndex(index: Int) {
        print("click \(index) image")
    }
