import gleam/bool
import app/web.{type Context, render}
import app/pages
import app/web/index
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  let req = wisp.method_override(req)
  use <- wisp.log_request(req)
  use <- default_responses(req, ctx)
  use <- wisp.rescue_crashes
  use <- wisp.serve_static(req, under: "/assets", from: ctx.dist_directory)
  case wisp.path_segments(req) {
    [] -> index.render(req, ctx)
    ["hello"] -> index.handle_request(req, ctx)
    _ -> wisp.not_found()
  }
}

fn default_responses(
  req: Request,
  ctx: Context,
  handle_request: fn() -> Response,
) -> Response {
  let res = handle_request()

  // Do not intercept redirects
  use <- bool.guard(when: res.status >= 300 && res.status < 400, return: res)
  use <- bool.guard(when: res.body != wisp.Empty, return: res)
  render(pages.error(ctx, req, res.status), res.status)
}
