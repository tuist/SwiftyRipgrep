import XCTest
import SwiftyRipgrep

class SwiftyRipGrepTests: XCTestCase {
    func test_itWorks() {
        // Given
        let subject = SwiftyRipgrep()
        let result = subject.grep(term: "foo", options: .init(parallel: false))
        
        // Then
        XCTAssertEqual(result, ["Hello from Rust!"])
    }
}
