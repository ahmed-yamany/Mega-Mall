import Foundation

/// DetailNews Input & Output
///
typealias DetailNewsViewModelType = DetailNewsViewModelInput & DetailNewsViewModelOutput

/// DetailNews ViewModel Input
///
protocol DetailNewsViewModelInput {
    var news: News { get }
    init(news: News)
}

/// DetailNews ViewModel Output
///
protocol DetailNewsViewModelOutput {}
