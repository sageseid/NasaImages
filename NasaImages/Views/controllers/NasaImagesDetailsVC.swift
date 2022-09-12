//
//  NasaImagesDetailsVC.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
import UIKit
import Combine

class NasaImagesDetailsVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descText: UITextView!
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
    }
    
    var titleLabelText: String?
    var descLabelText: String?
    var descTextString: String?
    var uiImageString: String?
    var uiImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
    }
    
    func setValues(){
        titleLabel.text = titleLabelText
        descLabel.text = descLabelText
        descText.text = descTextString
        imageView.setImageFromUrl(ImageURL: uiImageString ?? "https://bitsofco.de/content/images/2018/12/broken-1.png")
    }
    
    
    func getDetails(data:Item){
        titleLabelText = data.data[0].title
        descLabelText = "\(data.data[0].photographer ?? "name not found") | \(formatdate(dateString: data.data[0].date_created ?? "date not found"))"
        descTextString = data.data[0].description
        uiImageString =  data.links[0].href
    }
    
}

extension UIViewController {
    
    func formatdate(dateString: String) -> String{
        let nonTDateString = dateString.replacingOccurrences(of: "T", with: "")
        let nonZDateString = nonTDateString.replacingOccurrences(of: "Z", with: "")
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-mm-ddHH:mm:ss"
        let date = inputDateFormatter.date(from: nonZDateString) ?? Date()
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMM, yyyy"
        return outputDateFormatter.string(from: date)
    }
}
