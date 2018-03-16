//
//  ConnectionManager.swift
//  Docplexus_demo
//
//  Created by Priyanka Kanse on 16/03/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit
let imageCache = NSCache<NSString, AnyObject>()


class ConnectionManager: NSObject {

}

//image download
extension UIImageView {
    

    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        
        // setup loader
        let activityIndicatior = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatior.backgroundColor = UIColor(white: 0, alpha: 0.2) // make bg darker for greater contrast
        self.addSubview(activityIndicatior)
        
        // start loader
        activityIndicatior.frame = self.frame // center it
        activityIndicatior.startAnimating()



        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let imageToCache = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async() {
                imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                self.image = imageToCache
                //stop loader
                activityIndicatior.stopAnimating()
                activityIndicatior.removeFromSuperview()
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        }
        else{
        downloadedFrom(url: url, contentMode: mode)
        }
    }
    

}
