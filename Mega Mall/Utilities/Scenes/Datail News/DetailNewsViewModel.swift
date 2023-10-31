import Foundation

// MARK: DetailNewsViewModel
//
class DetailNewsViewModel {
    let news: News
    required init(news: News) {
        self.news = news
    }
}

// MARK: DetailNewsViewModel
//
extension DetailNewsViewModel: DetailNewsViewModelInput {}

// MARK: DetailNewsViewModelOutput
//
extension DetailNewsViewModel: DetailNewsViewModelOutput {}

// MARK: Private Handlers
//
private extension DetailNewsViewModel {}
