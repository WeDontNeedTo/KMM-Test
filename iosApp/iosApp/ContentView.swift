import SwiftUI
import shared

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    
    var body: some View {
        NavigationView {
            listView
                .navigationBarTitle("SpaceX Launches")
                .navigationBarItems(trailing:
                                        Button("Reload") {
                                            self.viewModel.loadLaunches(forceReload: true)
                                        })
        }
    }
    
    private var listView: some View {
        Group {
            switch viewModel.launches {
            case .loading:
                Text("Loading...").multilineTextAlignment(.center)
            case .result(let launches):
                RocketLaunchList(rocketLaunches: launches)
            case .error(let description):
                Text("Error: " + description).multilineTextAlignment(.center)
            }
        }
        
    }
    
}

extension ContentView {
    enum LoadableLaunches {
        case loading
        case result([RocketLaunch])
        case error(String)
    }
    
    class ViewModel: ObservableObject {
        @Published var launches = LoadableLaunches.loading
        
        let sdk: SpaceXSDK
        
        init(sdk: SpaceXSDK) {
            self.sdk = sdk
            self.loadLaunches(forceReload: false)
        }
        
        func loadLaunches(forceReload: Bool) {
            self.launches = .loading
            sdk.getLaunches(forceReload: forceReload, completionHandler: { launches, error in
                if let launches = launches {
                    self.launches = .result(launches)
                } else {
                    self.launches = .error(error?.localizedDescription ?? "error")
                }
            })
        }
    }
}


