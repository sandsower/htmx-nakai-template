import gleam/option.{type Option}
import nakai
import nakai/html.{type Node}
import wisp

pub type Context {
  Context(
    secret: String,
    dist_directory: String,
    session_token: Option(String),
  )
}

pub fn render(page: Node(t), code: Int) {
  page
  |> nakai.to_string_builder
  |> wisp.html_response(code)
}
