import Parsing
import XCTest

final class AnyParserTests: XCTestCase {
  func testClosureInitializer() {
    struct ParsingError: Error {}

    let parser = AnyParser<Substring, Void> { input in
      guard input.starts(with: "Hello") else { throw ParsingError() }
      input.removeFirst(5)
      return ()
    }

    var input = "Hello, world!"[...]
    XCTAssertNoThrow(try parser.parse(&input))
    XCTAssertEqual(", world!", input)

    XCTAssertThrowsError(try parser.parse(&input))
    XCTAssertEqual(", world!", input)
  }

  func testParserInitializer() {
    let parser = AnyParser("Hello")

    var input = "Hello, world!"[...]
    XCTAssertNoThrow(try parser.parse(&input))
    XCTAssertEqual(", world!", input)

    XCTAssertThrowsError(try parser.parse(&input))
    XCTAssertEqual(", world!", input)
  }

  func testParserEraseToAnyParser() {
    let parser = "Hello".eraseToAnyParser()

    var input = "Hello, world!"[...]
    XCTAssertNoThrow(try parser.parse(&input))
    XCTAssertEqual(", world!", input)

    XCTAssertThrowsError(try parser.parse(&input))
    XCTAssertEqual(", world!", input)
  }

  func testAnyParserEraseToAnyParser() {
    let parser = "Hello".eraseToAnyParser().eraseToAnyParser()

    var input = "Hello, world!"[...]
    XCTAssertNoThrow(try parser.parse(&input))
    XCTAssertEqual(", world!", input)

    XCTAssertThrowsError(try parser.parse(&input))
    XCTAssertEqual(", world!", input)
  }
}
