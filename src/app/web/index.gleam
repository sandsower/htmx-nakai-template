import app/components/header
import app/models
import app/pages
import app/pages/layout
import app/service
import app/web.{type Context}
import gleam/http.{Get}
import wisp.{type Request, type Response}

pub fn render(req: Request, ctx: Context) -> Response {
  use <- wisp.require_method(req, Get)
  pages.index()
  |> layout.render(layout.Props(
    title: "app",
    ctx: ctx,
    req: req,
    route: models.Index,
  ))
  |> web.render(200)
}

pub fn handle_request(req: Request, _ctx: Context) -> Response {
  use <- wisp.require_method(req, Get)

  service.hello()
  |> header.component
  |> web.render(200)
}
