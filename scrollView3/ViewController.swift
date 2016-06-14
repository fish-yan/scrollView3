//
//  ViewController.swift
//  scrollView3
//
//  Created by 薛焱 on 16/6/14.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    var imageArray = [String]()
    var index:NSInteger = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = ["1", "2", "3", "4"]
        imageView1.image = UIImage(named: imageArray.last!)
        imageView2.image = UIImage(named: imageArray[0])
        imageView3.image = UIImage(named: imageArray[1])
        index = 0;
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func panAction(sender: UIPanGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let frameY = imageView.frame.minY
        let frameWidth = imageView.frame.width
        let frameHeight = imageView.frame.height
        var lastTag = imageView.tag - 1
        var nextTag = imageView.tag + 1
        if lastTag < 1 {
            lastTag = 3
        }
        if nextTag > 3 {
            nextTag = 1
        }
        let lastImage = self.view.viewWithTag(lastTag) as! UIImageView
        let nextImage = self.view.viewWithTag(nextTag) as! UIImageView
        let translateX = sender.translationInView(sender.view).x
        var frameX:CGFloat = 0;
        switch sender.state {
        case .Changed:
            frameX = translateX
        case .Cancelled, .Ended:
            if (translateX > 0 ? translateX : -translateX) > frameWidth / 3 {
                frameX = translateX > 0 ? frameWidth : -frameWidth
            }
        default:
            break
        }
        UIView.animateWithDuration(0.2, animations: {
            
            lastImage.frame = CGRect(x: -frameWidth + frameX, y: frameY, width: frameWidth, height: frameHeight)
            imageView.frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
            nextImage.frame = CGRect(x: frameWidth + frameX, y: frameY, width: frameWidth, height: frameHeight)
            
            }, completion: { (finish) in
                if lastImage.frame.origin.x == -frameWidth * 2 {
                    lastImage.frame =  CGRect(x: frameWidth, y: frameY, width: frameWidth, height: frameHeight)
                    self.index += 1
                    if self.index == self.imageArray.count {
                        self.index = 0
                    }
                    if self.index + 1 == self.imageArray.count {
                        lastImage.image = UIImage(named: self.imageArray[0])
                    }else{
                        lastImage.image = UIImage(named: self.imageArray[self.index + 1])
                    }
                    
                    
                }
                if nextImage.frame.origin.x == frameWidth * 2 {
                    nextImage.frame =  CGRect(x: -frameWidth, y: frameY, width: frameWidth, height: frameHeight)
                    self.index -= 1
                    if self.index == -1 {
                        self.index = self.imageArray.count - 1
                    }
                    if self.index == 0 {
                        lastImage.image = UIImage(named: self.imageArray[self.imageArray.count - 1])
                    }else{
                        lastImage.image = UIImage(named: self.imageArray[self.index - 1])
                    }
                }
                imageView.image = UIImage(named: self.imageArray[self.index])
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

