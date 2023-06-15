#[macro_use] extern crate rocket;
mod auth;

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/api", routes![auth::login::login])
                    .mount("/api", routes![auth::register::register])
}