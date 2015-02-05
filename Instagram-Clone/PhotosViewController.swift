//
//  PhotosViewController.swift
//  Instagram-Clone
//
//  Created by Rachel Thomas on 2/4/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var photosTableView: UITableView!
    var photos: NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PhotoTableViewCell", bundle: NSBundle.mainBundle())
        photosTableView.rowHeight = 320;
        self.photosTableView.registerNib(nib, forCellReuseIdentifier: "MyPhotoCell")

        // Do any additional setup after loading the view.
        var clientId = "603a17589c024cc1be786761aee07158"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.photos = responseDictionary["data"] as NSArray
            println("response: \(self.photos)")
            self.photosTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = photos {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let photoCell = tableView.dequeueReusableCellWithIdentifier("MyPhotoCell") as PhotoTableViewCell
        let photo = photos![indexPath.row] as NSDictionary
        let imagesDict = photo["images"] as NSDictionary
        let lowRes = imagesDict["low_resolution"] as NSDictionary
        let photoURL = lowRes["url"] as NSString
        photoCell.PhotoImageView.setImageWithURL(NSURL(string:photoURL))
        return photoCell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
