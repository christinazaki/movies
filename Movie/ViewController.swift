//
//  ViewController.swift
//  Movie
//
//  Created by christina zaki on 10/26/19.
//  Copyright © 2019 christina zaki. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ViewController: UIViewController {
    
    
   
    @IBOutlet weak var moviesVC: UICollectionView!
    var movies = [movie]()
    let baseURL = "https://api.themoviedb.org/3"
    var pagee : Int? = 1
    //var pagePrev : Int? = 1
     let endPoint = "/discover/movie"
     lazy var completeUrl = baseURL + endPoint + "?api_key=acea91d2bff1c53e6604e4985b6989e2&page="
 
        + "\(pagee)"
    // lazy dih btob2a m3 el var bs m4 m3 let w m3anha en m4 btat7t 3la memoery f nafs wa2t elli et7at elli fo2iha
    override func viewDidLoad() {
        super.viewDidLoad()
        print("kkk")
        // Do any additional setup after loading the view.
        getMovies()
    }
    func getMovies()  {
         ////////////////////// elli 1 tari2a /////////
        
//        Alamofire.request(
//            completeUrl, method: .get, parameters: nil, encoding: JSONEncoding.default
//            , headers: nil).responseJSON
//            {response in
//                switch response.result{
//                case.success(_):
//                    print("sucess")
//                    let data =  response.data
//                    print(response.value)
//                    do{
//                        let value = try JSONSerialization.jsonObject(with:data! , options: []) as! [String: Any]
//
//                        let  title = value["results"]
//                            as? [[String:Any]]
//                        print(title)
//                        for indexx in title! {
//                            let original_title = indexx["title"] as! String
//
//                            print("hhhh")
//                            print(original_title)
//                        }
//
//                    }
//                    catch{
//                        print("error")
//                    }
//                case.failure(_):
//                    print("fff")
//
//                }
//
//        }
        
        ////////////////////// elli 2 tari2a /////////
        Alamofire.request(
                    completeUrl, method: .get, parameters: nil, encoding: JSONEncoding.default
            , headers: nil).validate().responseJSON { (res) in
                 print(res)
                if res.result.isSuccess {
                    print("success")
           let  jsonData = res.result.value as? [String: Any]
               let results       =  jsonData?["results"] as? [[String:Any]]
                    for movieDictionary in results! {
                     let mov =   movie( dictionary:movieDictionary)
                        self.movies.append(mov)
                    }
                    self.moviesVC.reloadData()
                }
                else {
                    print("failure")
                }
        }
       
   }

    @IBAction func nextBtn(_ sender: Any) {
        self.pagee = pagee! + 1
        print(pagee!)
       self.completeUrl = baseURL + endPoint + "?api_key=acea91d2bff1c53e6604e4985b6989e2&page="
            
            + "\(pagee!)"
        print (completeUrl)
        print("Oooooo")
        Alamofire.request(
            completeUrl, method: .get, parameters: nil, encoding: JSONEncoding.default
            , headers: nil).validate().responseJSON { (res) in
                print(res)
                if res.result.isSuccess {
                    print("success")
                    let  jsonData = res.result.value as? [String: Any]
                    let results       =  jsonData?["results"] as? [[String:Any]]
                    self.movies.removeAll()
                    for movieDictionary in results! {
                        let mov =   movie( dictionary:movieDictionary)
                        self.movies.append(mov)
                    }
                    self.moviesVC.reloadData()
                }
                else {
                    print("failure")
                }
        }

    }
    @IBAction func prevBtn(_ sender: Any) {
        if(self.pagee! >= 1){
        self.pagee = pagee! - 1
        print(pagee!)
        self.completeUrl = baseURL + endPoint + "?api_key=acea91d2bff1c53e6604e4985b6989e2&page="
            
            + "\(pagee!)"
        print (completeUrl)
        print("Oooooo")
        Alamofire.request(
            completeUrl, method: .get, parameters: nil, encoding: JSONEncoding.default
            , headers: nil).validate().responseJSON { (res) in
                print(res)
                if res.result.isSuccess {
                    print("success")
                    let  jsonData = res.result.value as? [String: Any]
                    let results       =  jsonData?["results"] as? [[String:Any]]
                    self.movies.removeAll()
                    for movieDictionary in results! {
                        let mov =   movie( dictionary:movieDictionary)
                        self.movies.append(mov)
                    }
                    self.moviesVC.reloadData()
                }
                else {
                    print("failure")
                }
        }
        }else{}
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movies.count)
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie =  movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
       cell.title.text = movie.title
        cell.productionYear.text = movie.productionYear
        cell.rate.text = "\(movie.rate)"
        if let url = URL(string: movie.imageUrl)
        {
            cell.image.af_setImage(withURL: url)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 10) / 2
        let height = 1.5 * width
        let size = CGSize(width: width , height: height)
        
        return size
    }
    
}
