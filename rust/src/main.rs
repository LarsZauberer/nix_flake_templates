//! Command-line entry point for the application.

use std::io::{self, Write};

fn main() -> io::Result<()> {
    writeln!(io::stdout().lock(), "{}", my_project::greeting())
}
