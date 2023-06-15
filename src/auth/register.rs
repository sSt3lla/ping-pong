use rocket::http::Status;
use rocket::serde::json::Json;
use serde::{Serialize, Deserialize};


#[derive(FromForm, Serialize, Deserialize)]
pub struct Register {
    name: String,
    email: String,
    username: String,
}

#[post("/register", format="json", data="<user>")]
pub fn register(user: Json<Register>) -> Status{

    //Print the user data
    println!("Name: {}", user.name);
    println!("Email: {}", user.email);
    println!("Username: {}", user.username);

    //Return a success status
    Status::Ok
}
