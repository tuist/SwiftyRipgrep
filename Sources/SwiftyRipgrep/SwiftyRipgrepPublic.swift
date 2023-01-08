public protocol SwiftyRipgrepping {
    func grep(term: String, options: RipgrepOptions) -> [String]
}

public class SwiftyRipgrep {
    public init() {}
    
    public func grep(term: String, options: RipgrepOptions) -> [String] {
        ripgrep(term, options).map { element in
            return element.as_str().toString()
        }
    }
}
