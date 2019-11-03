

import UIKit

class movie {
     var overView: String
    var title : String
    var productionYear : String
    var imageUrl : String
    var rate : Double
    
    init(dictionary: [String:Any]) {
        self.overView = dictionary["overview"] as? String ?? ""
        self.title = dictionary["title"] as? String ??  ""
        
        
        
        
        self.imageUrl = "https://image.tmdb.org/t/p/original" + (dictionary["poster_path"] as? String ?? "")
        
        let releaseDate = dictionary["release_date"] as? String ?? ""
        self.productionYear = releaseDate.components(separatedBy: "-").first ?? ""
        // dih fun bt3ml substring lw 3iza a5od shahr [1]
        self.rate = dictionary["vote_average"] as? Double ?? 0
        
    }
}
