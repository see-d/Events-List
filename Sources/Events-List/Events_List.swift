import UIKit

public struct Events_List {
    public init() {}
    
    public func loadController() -> UIViewController {
        let viewmodel = Feature.Domain.Sport.ViewModel()
        return Feature.Domain.Sport.EventsController(with: viewmodel)
    }
}
