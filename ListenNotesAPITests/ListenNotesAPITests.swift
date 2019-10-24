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

    override func setUp() {
        ListenNotesAPI.Config.set(apiKey: apiKey)
    }
    
    func testGetEpisode() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getEpisode(byId: LNData.episodeId) { result in
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
        ListenNotesAPI.getEpisodesBatch(withIds: LNData.episodeIds) { result in
            switch result {
            case .success(let episodes):
                let titles = episodes.map { $0.title }
                print(titles)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    func testGetPodcast() {
        let expectation = XCTestExpectation()
        ListenNotesAPI.getPodcast(byId: LNData.podcastId) { result in
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
            withIds: LNData.podcastIds,
            withRssUrls: LNData.rssUrls,
            withiTunesIds: LNData.iTunesIds
        ) { result in
            switch result {
            case .success(let podcasts):
                let titles = podcasts.map { $0.title }
                print(titles)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }

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
    
    let defaultTimeout: TimeInterval = 10
    
    final class LNData {
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
    }
}
