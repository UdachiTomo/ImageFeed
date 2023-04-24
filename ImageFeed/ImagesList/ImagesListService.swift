 import UIKit
final class ImagesListService {
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    static let shared = ImagesListService()
    private (set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private var task: URLSessionTask?
    private let perPage = "10"
    
    struct Photo {
        let id: String
        let size: CGSize
        let createdAt: Date?
        let welcomeDescription: String?
        let thumbImageURL: String?
        let largeImageURL: String?
        let isLiked: Bool
    }
    
    struct PhotoResult: Decodable {
        let id: String
        let createdAt: String?
        let welcomeDescription: String?
        let isLiked: Bool
        let width : Int?
        let height: Int?
        let urls: UrlsResult?
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case createdAt = "created_at"
            case welcomeDescription = "description"
            case isLiked = "liked_by_user"
            case width = "width"
            case height = "height"
            case urls = "urls"
        }
    }
    
    struct UrlsResult: Decodable {
        let thumbImageURL: String?
        let largeImageURL: String?
        
        enum CodingKeys: String, CodingKey {
            case thumbImageURL = "thumb"
            case largeImageURL = "full"
        }
    }
    
    func fetchPhotosNextPage() {
        assert(Thread.isMainThread)
        task?.cancel()
        let nextPage = lastLoadedPage == nil
            ? 1
            : lastLoadedPage! + 1
        guard let token = OAuth2TokenStorage.token else { return }
        guard let request = fetchImageListRequest(token, page: String(nextPage), perPage: perPage) else { return }
        let task = URLSession.shared.object(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.task = nil
                switch result {
                case .success(let photosResults):
                    photosResults.forEach { image in
                        let date = DateFormatter().date(from: image.createdAt ?? "")
                        guard let thumbImage = image.urls?.thumbImageURL,
                              let fullImage = image.urls?.largeImageURL else { return }
                        self.photos.append(Photo(id: image.id,
                                                 size: CGSize(width: image.width ?? 0, height: image.height ?? 0),
                                                 createdAt: date,
                                                 welcomeDescription: image.welcomeDescription,
                                                 thumbImageURL: thumbImage,
                                                 largeImageURL: fullImage,
                                                 isLiked: image.isLiked))
                        NotificationCenter.default.post(name: ImagesListService.didChangeNotification,
                                                        object: self,
                                                        userInfo: ["Images": self.photos])
                        self.lastLoadedPage = nextPage
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        self.task = task
        task.resume()
    }
    
    private func fetchImageListRequest(_ token: String, page: String, perPage: String) -> URLRequest? {
        var request = URLRequest.makeHTTPRequest(
             path: "/photos?page=\(page)&&per_page=\(perPage)",
             httpMethod: "GET",
             baseURL: URL(string: "https://api.unsplash.com")!
         )
         request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
         return request
     }
}
