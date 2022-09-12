//
//  NasaImagesListVC.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
import UIKit
import Combine

class NasaImagesListVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
    let cellID = "NasaTableViewCell"
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    let viewModel = NasaImagesViewModel()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var DataSource: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader()
        setupTableView()
        fetchData()
        
    }
    
    private func setupTableView() {
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    private func fetchData() {
        viewModel.$NasaData.sink { [weak self] items in
            if items.count > 0 {
                self?.DataSource = items
                self?.TableView.reloadData()
                self?.hideLoader()
            }
        }.store(in: &cancellableSet)
        
        viewModel.$errorMessage.sink { [weak self] message in
            if let errorMessage = message {
                self?.hideLoader()
                self?.showAlert(errorMsg: errorMessage)
            }
        }.store(in: &cancellableSet)
    }
    
    func hideLoader(){
        ActivityIndicator.stopAnimating()
        ActivityIndicator.isHidden = true
    }
    
    func showLoader(){
        ActivityIndicator.isHidden = false
        ActivityIndicator.startAnimating()
    }
    
    
    
    private func showAlert(errorMsg: String) {
        let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TableCell
        else {
            return UITableViewCell()
            
        }
        let elem = DataSource[indexPath.row].data[0]
        cell.updateViews(elem: elem)

        let formatUrlString = DataSource[indexPath.row].links[0].href.replacingOccurrences(of: " ", with: "%20")
        ImageLoader.sharedInstance.imageForUrl(urlString: formatUrlString, completionHandler: { (image, url) in
                        if image != nil {
                        cell.nasaImageView.image = image
                        } else {
                            cell.nasaImageView.image =  #imageLiteral(resourceName: "Loading_Default_Picture")
                        }
                    })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let elem = DataSource[indexPath.row]
        performSegue(withIdentifier: "gotoDetails", sender: elem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if  let DetailVc = segue.destination as? NasaImagesDetailsVC{
            assert(sender as? Item != nil)
            DetailVc.getDetails(data: sender as! Item )
        }
    }
}

extension UIImageView {
    
    func setImageFromUrl(ImageURL :String) {
      guard let factcheckImageurl = URL(string: ImageURL) else { return  }
       URLSession.shared.dataTask( with: factcheckImageurl, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.image = UIImage(data: data)
             }
          }
       }).resume()
    }
    
}
