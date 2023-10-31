import Foundation
import Combine

// MARK: AllNewsViewModel
//
class AllNewsViewModel {
    var cancellableSet: Set<AnyCancellable> = []
    ///
    func getNews() -> AnyPublisher<[News], Never> {
        Just([
            .init(titel: "Philosophy That Addresses Topics Such As Goodness",
                  subtitle: "Agar tetap kinclong, bodi motor ten...",
                  date: "13 Jan 2021", image: "data-news-1"),
            .init(titel: "Many Inquiries Outside Of Academia Are Philosophical In The Broad Sense",
                  subtitle: "In one general sense, philosophy is ass...",
                  date: "13 Jan 2021", image: "data-news-2"),
            .init(titel: "Tips Merawat Bodi Mobil agar Tidak Terlihat Kusam",
                  subtitle: "Agar tetap kinclong, bodi motor ten...",
                  date: "13 Jan 2021", image: "data-news-3"),
            .init(titel: "Philosophy That Addresses Topics Such As Goodness",
                  subtitle: "Agar tetap kinclong, bodi motor ten...",
                  date: "13 Jan 2021", image: "data-news-1"),
            .init(titel: "Many Inquiries Outside Of Academia Are Philosophical In The Broad Sense",
                  subtitle: "In one general sense, philosophy is ass...",
                  date: "13 Jan 2021", image: "data-news-2"),
            .init(titel: "Tips Merawat Bodi Mobil agar Tidak Terlihat Kusam",
                  subtitle: "Agar tetap kinclong, bodi motor ten...",
                  date: "13 Jan 2021", image: "data-news-3"),
            .init(titel: "Philosophy That Addresses Topics Such As Goodness",
                  subtitle: "Agar tetap kinclong, bodi motor ten...",
                  date: "13 Jan 2021", image: "data-news-1"),
            .init(titel: "Many Inquiries Outside Of Academia Are Philosophical In The Broad Sense",
                  subtitle: "In one general sense, philosophy is ass...",
                  date: "13 Jan 2021", image: "data-news-2"),
            .init(titel: "Tips Merawat Bodi Mobil agar Tidak Terlihat Kusam",
                  subtitle: "Agar tetap kinclong, bodi motor ten...",
                  date: "13 Jan 2021", image: "data-news-3")
        ]).eraseToAnyPublisher()
    }
}

// MARK: Private Handlers
//
private extension AllNewsViewModel {}
