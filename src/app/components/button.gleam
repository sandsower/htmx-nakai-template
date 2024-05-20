import nakai/html
import nakai/html/attrs

pub type Props(a) {
  Props(
    content: String,
    class: String,
    attrs: List(attrs.Attr(a)),
  )
}

pub fn component(props: Props(t)) -> html.Node(t) {
  html.button_text([attrs.class(props.class), ..props.attrs], props.content)
}
