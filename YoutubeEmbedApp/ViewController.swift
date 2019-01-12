//
//  ViewController.swift
//  YoutubeEmbedApp
//
//  Created by MAC on 6/1/19.
//  Copyright © 2019 cagdaseksi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var videos:[Video] = []
    var video:Video = Video()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let video = Video()
        video.Key = "Ou3bl5VQ3OA"
        video.Title = "Build a Count Down Timer with Swift 4.2"
        videos.append(video)
        
        let video2 = Video()
        video2.Key = "vL1FyHB-p7o"
        video2.Title = "How To Search For Places In MapView Using MapKit"
        videos.append(video2)
        
        let video3 = Video()
        video3.Key = "m377xDBPO6E"
        video3.Title = "How To Use The Shake Gesture Recogniser"
        videos.append(video3)
        
        let video4 = Video()
        video4.Key = "g67TvCJhpjU"
        video4.Title = "How To Hide The Status Bar In Xcode"
        videos.append(video4)
        
        let video5 = Video()
        video5.Key = "FzOsiD0V_j4"
        video5.Title = "How To Store Data Permanently With User Defaults"
        videos.append(video5)
        
        let video6 = Video()
        video6.Key = "nACyGQI-bH8"
        video6.Title = "How To Store Data Permanently With User Defaults"
        videos.append(video6)
        
        let video7 = Video()
        video7.Key = "ERcavWn_-ZM"
        video7.Title = "How To Display An Activity Indicator In xCode"
        videos.append(video7)
        
        let video8 = Video()
        video8.Key = "fFyC8vI2r2M"
        video8.Title = "How To Trigger A Segue In xCode 10"
        videos.append(video8)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoTableViewCell
        
        cell.videoTitle.text = videos[indexPath.row].Title
        let url = "https://img.youtube.com/vi/\(videos[indexPath.row].Key)/0.jpg"
        cell.videoImage.downloaded(from: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vi = videos[indexPath.row]
        self.video = vi
        
        performSegue(withIdentifier: "toVideo", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toVideo" {
            
            let vc = segue.destination as! VideoViewController
            vc.video = self.video
            
        }
        
    }
    
}

class Video{
    var Key:String = ""
    var Title:String = ""
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
