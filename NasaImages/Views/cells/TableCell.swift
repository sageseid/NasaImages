//
//  TableCell.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var nasaImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews( elem : DataElement) {
        nasaImageView.image = UIImage(named: "Loading_Default_Picture")
        title.text =  elem.title
        subTitle.text = "\(elem.photographer ?? "name not found") | \(formatdate(dateString: elem.date_created ?? "date not found"))"
    }
    
    
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


