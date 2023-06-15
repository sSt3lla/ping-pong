use rocket::http::Status;
use rocket::serde::json::Json;
use serde::{Serialize, Deserialize};


#[derive(FromForm, Serialize, Deserialize)]
pub struct Login {
    name: String,
    username: String,
}

#[post("/login", format="json", data="<user>")]
pub fn login(user: Json<Login>) -> Status{

    //Print the user data
    println!("Name: {}", user.name);
    println!("Username: {}", user.username);

    //Return a success status
    Status::Ok
}
