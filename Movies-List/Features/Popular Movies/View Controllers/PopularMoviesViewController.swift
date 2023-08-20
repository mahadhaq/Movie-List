//
//  PopularMoviesViewController.swift
//  Movies-List
//
//  Created by Mahad on 8/20/23.
//

import UIKit

private let reuseIdentifier = "PopularMovieCell"

class PopularMoviesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    var viewModel = PopularMoviesViewModel()
    // MARK: - Life cycle
    init() {
        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Popular"
        self.viewModel.set(view: self)
        
        // Register cell classes
        self.collectionView.register(UINib(nibName: reuseIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.page = 1
        self.viewModel.fetchMoviesList()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.viewModel.popularMoviesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PopularMovieCell
        // Configure the cell
        cell.config(movie: self.viewModel.popularMoviesList[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) * 0.5
        return CGSize(width: width, height: (width * 1.5))
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) && !viewModel.isPageRefreshing && viewModel.page < viewModel.totalPages {
            viewModel.isPageRefreshing = true
            viewModel.page = viewModel.page + 1
            viewModel.fetchMoviesList()
        }
    }
}
    

extension PopularMoviesViewController: PopularMoviesViewDelegate {
    func successfullyReceivedMoviesList() {
        self.collectionView.reloadData()
    }
    
    
}
