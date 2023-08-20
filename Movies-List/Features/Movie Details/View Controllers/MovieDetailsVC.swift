//
//  MovieDetailsVC.swift
//  Movies-List
//
//  Created by Mahad on 8/21/23.
//

import UIKit

class MovieDetailsVC: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var backdropImgView: UIImageView!
    @IBOutlet weak var posterImgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var GenreLbl: UILabel!
    @IBOutlet weak var tagline: UILabel!

    @IBOutlet weak var overviewLbl: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

// MARK: - Extensions
