import app/models
import app/web.{type Context}
import nakai/html
import nakai/html/attrs
import wisp

pub type Props {
  Props(title: String, ctx: Context, req: wisp.Request, route: models.Route)
}

pub fn header(title: String) -> html.Node(t) {
  html.Head([
    html.meta([attrs.charset("utf-8")]),
    html.Element("script", [attrs.src("/assets/js/htmx.min.js")], []),
    html.title(title),
  ])
}

pub fn render(child: html.Node(t), props: Props) -> html.Node(t) {
  let title = case props.title {
    "" -> "Template"
    title -> title
  }

  html.Fragment([
    header(title),
    html.Body(
      [
        attrs.class("mt-[9vh]"),
        attrs.id("main"),
        attrs.Attr("hx-ext", "response-targets"),
        attrs.Attr("hx-boost", "true"),
      ],
      [child],
    ),
  ])
}
