//
//  ListenNotesAPITests.swift
//  ListenNotesAPITests
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import XCTest
@testable import ListenNotesAPI

class ListenNotesAPITests: XCTestCase {
    
    let defaultTimeout: TimeInterval = 10
    
    override func setUp() {
        ListenNotesAPI.Config.set(apiKey: "YOUR_API_KEY")
    }
}

// MARK: Search
extension ListenNotesAPITests {
    
    func testSearchPodcasts() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.searchPodcasts(
            withText: TestData.searchText,
            filter: TestData.searchFilter
        ) { result in
            switch result {
            case .success(let searchResults):
                if searchResults.podcasts.isEmpty {
                    XCTFail("No podcasts found")
                }
                searchResults.podcasts.map { $0.title }.forEach {
                    print($0)
                }
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testSearchEpisodes() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.searchEpisodes(
            withText: TestData.searchText,
            filter: TestData.searchFilter
        ) { result in
            switch result {
            case .success(let searchResults):
                if searchResults.episodes.isEmpty {
                    XCTFail("No episodes found")
                }
                searchResults.episodes.map { $0.title }.forEach {
                    print($0)
                }
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
}

// MARK: Episodes
extension ListenNotesAPITests {
    
    func testGetEpisode() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getEpisode(byId: TestData.episodeId) { result in
            switch result {
            case .success(let episode):
                print(episode.title)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testGetEpisodesBatch() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getEpisodesBatch(withIds: TestData.episodeIds) { result in
            switch result {
            case .success(let episodes):
                if episodes.isEmpty {
                    XCTFail("No episodes found")
                }
                let titles = episodes.map { $0.title }
                print(titles)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testJustListen() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.justListen { result in
            switch result {
            case .success(let episode):
                print(episode.title)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testGetSimilarEpisodes() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getSimilarEpisodes(episodeId: TestData.episodeId) { result in
            switch result {
            case .success(let episodes):
                if episodes.isEmpty {
                    XCTFail("No episodes found")
                }
                let titles = episodes.map { $0.title }
                print(titles)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
}

// MARK: Podcasts
extension ListenNotesAPITests {
    
    func testGetPodcast() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getPodcast(byId: TestData.podcastId) { result in
            switch result {
            case .success(let podcast):
                print(podcast.title)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testGetPodcastBatch() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getPodcastsBatch(
            withIds: TestData.podcastIds,
            withRssUrls: TestData.rssUrls,
            withiTunesIds: TestData.iTunesIds
        ) { result in
            switch result {
            case .success(let podcasts):
                if podcasts.isEmpty {
                    XCTFail("No podcasts found")
                }
                let titles = podcasts.map { $0.title }
                print(titles)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testGetBestPodcasts() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getBestPodcasts { result in
            switch result {
            case .success(let bestPodcasts):
                let podcasts = bestPodcasts.podcasts
                if podcasts.isEmpty {
                    XCTFail("No podcasts found")
                }
                let titles = podcasts.map { $0.title }
                print(titles)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testGetBestPodcastsInGenre() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getBestPodcasts(
            byGenreId: TestData.genreId,
            page: TestData.page,
            regionCode: TestData.regionCode,
            filterExplicit: true
        ) { result in
            switch result {
            case .success(let bestPodcasts):
                let podcasts = bestPodcasts.podcasts
                if podcasts.isEmpty {
                    XCTFail("No podcasts found")
                }
                let titles = podcasts.map { $0.title }
                print(titles)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testGetSimilarPodcasts() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getSimilarPodcasts(podcastId: TestData.podcastId) { result in
            switch result {
            case .success(let podcasts):
                if podcasts.isEmpty {
                    XCTFail("No podcasts found")
                }
                let titles = podcasts.map { $0.title }
                print(titles)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
}

// MARK: Reference
extension ListenNotesAPITests {
    
    func testGetGenres() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getGenres { result in
            switch result {
            case .success(let genres):
                print(genres.map { $0.name } )
                XCTAssert(!genres.isEmpty)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testGetRegions() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getRegions { result in
            switch result {
            case .success(let regions):
                print(regions.map { $0.code + " : " + $0.name } )
                XCTAssert(!regions.isEmpty)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testGetLanguages() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getLanguages { result in
            switch result {
            case .success(let languages):
                print(languages)
                XCTAssert(!languages.isEmpty)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
}

// MARK: Test Data
extension ListenNotesAPITests {
    
    private final class TestData {
        static let episodeId = "02f0123246c944e289ee2bb90804e41b"
        static let episodeIds = [
            "c577d55b2b2b483c969fae3ceb58e362",
            "0f34a9099579490993eec9e8c8cebb82",
        ]
        static let podcastId = "4d3fe717742d4963a85562e9f84d8c79"
        static let podcastIds = [
            "3302bc71139541baa46ecb27dbf6071a",
            "68faf62be97149c280ebcc25178aa731",
            "37589a3e121e40debe4cef3d9638932a",
            "9cf19c590ff0484d97b18b329fed0c6a",
        ]
        static let rssUrls = [
            "https://rss.art19.com/recode-decode",
            "https://rss.art19.com/the-daily",
            "https://www.npr.org/rss/podcast.php?id=510331",
            "https://www.npr.org/rss/podcast.php?id=510331",
        ]
        static let iTunesIds = [
            1457514703,
            1386234384,
            659155419,
        ]
        static let searchText = "star wars"
        static let searchFilter: LNSearchFilter = {
            var filter = LNSearchFilter()
            filter.sortBy = .mostRecent
            filter.minMinuteLength = 30
            filter.maxMinuteLength = 60
            filter.searchInFields = [.title, .description]
            let twoYears: TimeInterval = 60 * 60 * 24 * 365 * 2
            let sixMonths: TimeInterval = twoYears / 4
            filter.publishedAfter = Date().addingTimeInterval(-twoYears)
            filter.publishedBefore = Date().addingTimeInterval(-sixMonths)
            filter.safeMode = .filterExplicit
            return filter
        }()
        static let genreId = 97
        static let page = 2
        static let regionCode = "us"
    }
}
