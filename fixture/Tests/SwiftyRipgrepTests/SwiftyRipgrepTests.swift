import XCTest
import SwiftyRipgrep

class SwiftyRipGrepTests: XCTestCase {
    func test_itWorks() {
        // Given
        let result = hello_rust().toString()
        
        // Then
        XCTAssertEqual(result, "Hello from Rust!")
    }
}
