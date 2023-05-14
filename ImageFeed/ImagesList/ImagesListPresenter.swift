import UIKit

public protocol ImagesListPresenterProtocol {
    var view: ImagesListViewViewControllerProtocol? { get set }
    func timeSetup(_ date: Date) -> String
    func getCellURL(indexPath: IndexPath) -> URL?
    func isLiked(indexPath: IndexPath) -> Bool
    func imageListCellDidTapLike(_ cell: ImagesListCell, indexPath: IndexPath)
    func viewDidLoad()
}

final class ImagesListPresenter: ImagesListPresenterProtocol {
    weak var view: ImagesListViewViewControllerProtocol?
    private var imagesListService = ImagesListService.shared
    private var imagesListServiceObserver: NSObjectProtocol?
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    func timeSetup(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
    
    func getCellURL(indexPath: IndexPath) -> URL? {
        guard
            let imageCellUrl = imagesListService.photos[indexPath.row].thumbImageURL,
            let url = URL(string: imageCellUrl)
        else { return nil}
        return url
    }
    
    func isLiked(indexPath: IndexPath) -> Bool {
        return imagesListService.photos[indexPath.row].isLiked == false
    }
    
    func imageListCellDidTapLike(_ cell: ImagesListCell, indexPath: IndexPath) {
        let photo = view?.photos[indexPath.row]
        UIBlockingProgressHUD.show()
        imagesListService.changeLike(photoId: photo?.id ?? "", isLike: photo?.isLiked ?? true) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success:
                    self?.view?.photos = self?.imagesListService.photos ?? []
                    cell.setIsLiked(isLiked: self?.view?.photos[indexPath.row].isLiked ?? true)
                    UIBlockingProgressHUD.dismiss()
                case .failure:
                    UIBlockingProgressHUD.dismiss()
                }
            }
        }
    }
    
    func viewDidLoad() {
        imagesListService.fetchPhotosNextPage()
        imagesListServiceObserver = NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [ weak self ] _ in
            guard let self = self else { return }
            self.view?.updateTableViewAnimated()
        }
    }
}
