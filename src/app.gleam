import app/router
import app/web.{Context}
import gleam/erlang/os
import gleam/erlang/process
import gleam/int
import gleam/option.{None}
import gleam/result
import mist
import wisp

pub fn main() {
  wisp.configure_logger()

  let assert Ok(priv_directory) = wisp.priv_directory("app")

  let ctx =
    Context(
      secret: get_app_secret(),
      dist_directory: priv_directory <> "/static/dist",
      session_token: None,
    )

  let assert Ok(_) =
    router.handle_request(_, ctx)
    |> wisp.mist_handler(ctx.secret)
    |> mist.new
    |> mist.port(get_port())
    |> mist.start_http

  process.sleep_forever()
}

fn get_port() -> Int {
  os.get_env("PORT")
  |> result.then(int.parse)
  |> result.unwrap(8080)
}

fn get_app_secret() -> String {
  os.get_env("APP_SECRET")
  |> result.unwrap("")
}
