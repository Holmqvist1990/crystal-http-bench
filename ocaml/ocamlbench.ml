open Opium

let (let*) = Lwt.bind

type residence = {
    street: string;
    city: string;
    country: string; } [@@deriving yojson]

type person = { 
    name: string; 
    email: string;
    residences: residence list; } [@@deriving yojson]

let people = ref []

let get = App.get "/" (fun _req -> 
    let people = !people in
    let json = [%to_yojson: person list] people in
    Lwt.return (Response.of_json json))

let insert = App.post "/" (fun request ->
    let* input_json = Request.to_json_exn request in
    let input_person = 
        match person_of_yojson input_json with
        | Ok message -> message
        | Error error -> raise (Invalid_argument error)
    in
    people := input_person :: !people;
    Response.make ~status: `OK ()
    |> Response.add_header_unless_exists ("Connection", "Keep-Alive")
    |> Lwt.return)

let () = App.empty 
    |> get
    |> insert
    |> App.run_command
