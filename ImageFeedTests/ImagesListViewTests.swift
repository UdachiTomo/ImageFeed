@testable import ImageFeed
import XCTest

final class ImagesListViewTests: XCTestCase {
    
    func testGetDateForCell() {
        let presenter = ImagesListPresenter()
        let viewController = ImagesListViewController()
        viewController.configure(presenter)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let dateCell = formatter.date(from: "2023/07/28 11:11") else { return }
        
        let date = presenter.timeSetup(dateCell)
        
        XCTAssertEqual(date, "28 июня 2023 г.")
    }
}
