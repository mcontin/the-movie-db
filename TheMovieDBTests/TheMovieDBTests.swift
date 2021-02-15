//
//  TheMovieDBTests.swift
//  TheMovieDBTests
//
//  Created by Mattia on 10/02/21.
//

import XCTest
@testable import TheMovieDB

class TheMovieDBTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMoviesAreMappedCorrectlyIn() throws {
        let mockRemoteStore = MockRemoteMoviesStore()
        let localStore = MemoryMoviesStore()
        let repo = MoviesRepository(localStore: localStore, remoteStore: mockRemoteStore)
        
        repo.getMovies(page: 1) { result in
            switch result {
            case .success(let movies):
                // check same count
                XCTAssert(mockRemoteStore.expectedMovies.count == movies.count)
                
                // fetch from local
                localStore.getMovies(page: 1) { result in
                    switch result {
                    case .success(let localMovies):
                        // assert size in local store
                        XCTAssert(localMovies.count == movies.count)
                        
                        // basic check for title between mocked movies & locally stored movies
                        for (mockRemoteMovie, localMovie) in zip(movies, localMovies) {
                            XCTAssert(mockRemoteMovie.title == localMovie.title)
                        }
                    case .failure:
                        XCTFail()
                    }
                }
            case .failure:
                break
            }
        }
    }

}
