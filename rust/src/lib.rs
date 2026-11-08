//! Application logic shared by the executable and library consumers.
//!
//! Keep business logic here and let the executable handle input and output.

/// Returns the application's welcome message.
///
/// # Examples
///
/// ```
/// assert_eq!(my_project::greeting(), "Hello, Rust!");
/// ```
#[must_use]
pub const fn greeting() -> &'static str {
    "Hello, Rust!"
}

#[cfg(test)]
mod tests {
    use super::greeting;

    #[test]
    fn greeting_is_the_expected_message() {
        assert_eq!(greeting(), "Hello, Rust!");
    }
}
