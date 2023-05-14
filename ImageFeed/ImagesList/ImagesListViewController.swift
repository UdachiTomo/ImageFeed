import UIKit
import Kingfisher

public protocol ImagesListViewViewControllerProtocol: AnyObject {
    var presenter: ImagesListPresenterProtocol? { get set }
    var photos: [Photo] { get set }
    func updateTableViewAnimated()
}

final class ImagesListViewController: UIViewController & ImagesListViewViewControllerProtocol {
    
    var presenter: ImagesListPresenterProtocol?
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let ShowSingleImageSegueIdentifier = "ShowSingleImage"
    private let imagesListService = ImagesListService.shared
    private var imagesListServiceObserver: NSObjectProtocol?
    var photos: [Photo] = []

    func configure(_ presenter: ImagesListPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    func updateTableViewAnimated() {
        let oldCount = photos.count
        let newCount = imagesListService.photos.count
        photos = imagesListService.photos
        if oldCount != newCount {
            
            tableView.performBatchUpdates {
                let indexPath = (oldCount..<newCount).map { i in
                    IndexPath(row: i, section: 0)
                }
                tableView.insertRows(at: indexPath, with: .automatic)
            } completion: { _ in }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowSingleImageSegueIdentifier {
            guard let viewController = segue.destination as? SingleImageViewController else { return }
            guard let indexPath = sender as? IndexPath else { return }
            if let url = imagesListService.photos[indexPath.row].largeImageURL,
               let imageUrl = URL(string: url) {
                viewController.singleImageURL = imageUrl
                
            }
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        imagesListService.fetchPhotosNextPage()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ShowSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageHeight = imagesListService.photos[indexPath.row].size.height
        let imageWidth = imagesListService.photos[indexPath.row].size.width
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let scale = imageViewWidth / imageWidth
        let cellHeight = imageHeight * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}

extension ImagesListViewController: UITableViewDataSource {
    
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesListService.photos.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            imagesListService.fetchPhotosNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        imageListCell.delegate = self
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}

extension ImagesListViewController {
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        if let url = presenter?.getCellURL(indexPath: indexPath) {
            cell.imageCell.kf.indicatorType = .activity
            cell.imageCell.kf.setImage(with: url,
                                       placeholder: UIImage(named: "scribble")) { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            if let date = imagesListService.photos[indexPath.row].createdAt {
                cell.dateCell.text = presenter?.timeSetup(date)
            } else {
                cell.dateCell.text = ""
            }
            let isLiked = presenter?.isLiked(indexPath: indexPath)
            let likedImage = isLiked ?? true ? UIImage(named: "no_active_photo") : UIImage(named: "active_photo")
            cell.likeCell.setImage(likedImage, for: .normal)
            cell.selectionStyle = .none
        }
    }
}

extension ImagesListViewController: ImagesListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        presenter?.imageListCellDidTapLike(cell, indexPath: indexPath)
    }
}

