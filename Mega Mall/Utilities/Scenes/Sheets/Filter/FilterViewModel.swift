import Foundation
import Combine
// MARK: FilterViewModel
//
class FilterViewModel {
    public static let shared = FilterViewModel()
    //
    @Published var filters: [Filter] = []
    @Published var sort: Sort?
    var cancellableSet: Set<AnyCancellable> = []
    //
    private init() { }
    //
    public func getFilters() async -> [Filter] {
        [
            .init(title: "Semua Sub Kategori"),
            .init(title: "Handphone"),
            .init(title: "Computer"),
            .init(title: "Laptop")
        ]
    }
    //
    public func getSorts() async -> [Sort] {
        [
            .init(title: "Name (A-Z)"),
            .init(title: "Name (Z-A)"),
            .init(title: "Price (High-Low)"),
            .init(title: "Price (Low-High)")
        ]
    }
}

// MARK: Private Handlers
//
private extension FilterViewModel {}
