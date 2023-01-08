public func ripgrep<GenericIntoRustString: IntoRustString>(_ term: GenericIntoRustString, _ options: RipgrepOptions) -> RustVec<RustString> {
    RustVec(ptr: __swift_bridge__$ripgrep({ let rustString = term.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), options.intoFfiRepr()))
}
public struct RipgrepOptions {
    public var parallel: Bool

    public init(parallel: Bool) {
        self.parallel = parallel
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$RipgrepOptions {
        { let val = self; return __swift_bridge__$RipgrepOptions(parallel: val.parallel); }()
    }
}
extension __swift_bridge__$RipgrepOptions {
    @inline(__always)
    func intoSwiftRepr() -> RipgrepOptions {
        { let val = self; return RipgrepOptions(parallel: val.parallel); }()
    }
}
extension __swift_bridge__$Option$RipgrepOptions {
    @inline(__always)
    func intoSwiftRepr() -> Optional<RipgrepOptions> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<RipgrepOptions>) -> __swift_bridge__$Option$RipgrepOptions {
        if let v = val {
            return __swift_bridge__$Option$RipgrepOptions(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$RipgrepOptions(is_some: false, val: __swift_bridge__$RipgrepOptions())
        }
    }
}


