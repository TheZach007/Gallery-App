//
//  ListViewController.swift
//  Gallery-App
//
//  Created by Phincon on 20/01/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataList : [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Lists"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        
        fetchData()
        
    }
    
    func fetchData() {
        AF.request("https://jsonplaceholder.typicode.com/photos" , method: .get ,encoding: JSONEncoding.default).responseString {
                response in switch response.result {
                case .success(let data):
                    print(data)
                    
                    if let data = response.data {
                    guard let json = try? JSON(data: data) else { return }
                    print(json)
                    for (_, subJson) in json {
                        
                        let albumId = subJson["albumId"].int ?? 0
                        let id = subJson["id"].int ?? 0
                        let title = subJson["title"].string ?? ""
                        let url = subJson["url"].string ?? ""
                        let thumbnailUrl = subJson["thumbnailUrl"].string ?? ""
                        
                        self.dataList.append(List(albumId: albumId, id: id, title: title, url: url, thumbnailUrl: thumbnailUrl))
                        
                        }
                    }
                    self.fetchData()
                case .failure(let error):
                    print(error)
                }
        }
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        cell.idLabel.text = "\(dataList[indexPath.row].id)"
        cell.titleLabel.text = "\(dataList[indexPath.row].title)"
        
        if dataList[indexPath.row].url != "" {
            let url = URL(string: dataList[indexPath.row].url)
            let datas = try? Data(contentsOf: url!)

            if let imageData = datas {
                let image = UIImage(data: imageData)
                cell.photoImageView.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
