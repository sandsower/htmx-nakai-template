import nakai/html

pub fn component(text: String) {
  html.div([], [
    html.h1([], [
      html.Text(text)
    ])
  ])
}
