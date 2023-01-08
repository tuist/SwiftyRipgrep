#[swift_bridge::bridge]
mod ffi {
    #[swift_bridge::bridge(swift_repr = "struct")]
    struct RipgrepOptions {
        parallel: bool,
    }

    extern "Rust" {
        fn ripgrep(term: String, options: RipgrepOptions) -> Vec<String>;
    }
}

fn ripgrep(term: String, options: ffi::RipgrepOptions) -> Vec<String> {
    vec![String::from("Hello from Rust!")]
}
