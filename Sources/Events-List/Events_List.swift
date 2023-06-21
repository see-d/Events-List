import UIKit

public struct Events_List {
    public init() {}
    
    public func loadController() -> UIViewController {
        let repository = SportsRepository()
        let viewmodel = Feature.Domain.Sport.ViewModel(repository: repository)
        return Feature.Domain.Sport.EventsController(with: viewmodel)
    }
}
