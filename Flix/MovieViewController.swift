//
//  MovieViewController.swift
//  Flix
//
//  Created by bunny on 2019/1/25.
//  Copyright © 2019 codepath. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
   {
    
    
    //in order to work with tableview we need the above two functions and they are gonna get called just like how the viewDidLoad get called
    
    
    //variables created here are called properties, they are available for you the lifetime of that screen
    @IBOutlet weak var TableView: UITableView!
    var movies = [[String:Any]]() //initialize
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //that is run the first time that a screen comes up so this function is callede for you
        //and stuff you put in here will be called as soon as the screen comes up
        //eg.
        print("hELLO")
        TableView.dataSource = self
        TableView.delegate = self
        //FOR THIS ASSIGNMENT
      
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 self.movies = dataDictionary["results"] as! [[String:Any]]
                //as! is casting
                
                //because the tableview functions below does not get called continously, it only get called
                //once when the viewcontroller starts, parrallel with viewDidLoad
                //but at that time, we havent get the movie data above back
                //so we tell thetableview to reload the data which is call the two functions again
                //actually call the first one and then repeat call the second one the number of times the first function returns
                self.TableView.reloadData()
            
                // TODO: Get the array of movies
               
    
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MoiveCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        cell.titleLabel.text = title
        let syponsis = movie["overview"] as! String
        cell.synopsisLabel.text = syponsis
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        cell.posterView.af_setImage(withURL: posterUrl!)
        return cell
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
