import app/components/button
import nakai/html.{div}
import nakai/html/attrs

const target = "header"

pub fn page() -> html.Node(t) {
  div([attrs.id(target)], [
    button.component(button.Props(
      content: "Click me!",
      attrs: [
        attrs.Attr("hx-get", "hello"),
        attrs.Attr("hx-target", "#" <> target),
        attrs.Attr("hx-swap", "outerHTML"),
      ],
      class: "block w-max lg:mx-0 mt-6 lg:mt-8",
    )),
  ])
}
