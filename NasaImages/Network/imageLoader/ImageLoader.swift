//
//  ImageLoader.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
import UIKit

class ImageLoader {

    var cache = NSCache<AnyObject, AnyObject>()

    class var sharedInstance : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }

    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
            let data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData

            if let imageData = data {
                let image = UIImage(data: imageData as Data)
                DispatchQueue.main.async {
                    completionHandler(image, urlString)
                }
                return
            }
        guard let guardImageurl = URL.init(string: urlString ) else { return  }


        let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: guardImageurl) { (data, response, error) in
            if error == nil {
                if data != nil {
                    let image = UIImage.init(data: data!)
                    self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        completionHandler(image, urlString)
                    }
                }
            } else {
                completionHandler(nil, urlString)
            }
        }
        downloadTask.resume()
        }
    }

    

