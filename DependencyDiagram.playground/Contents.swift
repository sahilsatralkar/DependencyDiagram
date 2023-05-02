import UIKit

protocol FeedLoader {
    func loadFeed(completion: ([String]) -> Void)
}

class FeedViewController: UIViewController {
    var loadFeed: FeedLoader!
    
    convenience init(feed: FeedLoader) {
        self.init()
        self.loadFeed = feed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFeed.loadFeed { loadedItems in
            //Update UI
        }
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: ([String]) -> Void) {
        //do something
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: ([String]) -> Void) {
        //do something
    }
}

class RemoteFeedLoaderWithLocalBackup: FeedLoader {
    let remoteFeedLoader: RemoteFeedLoader
    let localFeedLoader: LocalFeedLoader
    
    init(remoteFeed: RemoteFeedLoader, localFeed: LocalFeedLoader) {
        self.remoteFeedLoader = remoteFeed
        self.localFeedLoader = localFeed
    }
    
    func loadFeed(completion: ([String]) -> Void) {
        let load = Network.networkAvailable  ?
            remoteFeedLoader.loadFeed : localFeedLoader.loadFeed
        load(completion)
    }
}

struct Network {
    static var networkAvailable = false
}

let vc = FeedViewController(feed: LocalFeedLoader())
let vc2 = FeedViewController(feed: RemoteFeedLoader())
let vc3 = FeedViewController(feed: RemoteFeedLoaderWithLocalBackup(remoteFeed: RemoteFeedLoader(),
                                                                   localFeed: LocalFeedLoader()))
