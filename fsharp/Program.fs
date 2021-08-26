open System
open System.Text.Json
open Suave
open Suave.Filters
open Suave.Operators
open Suave.Successful

type Residence =
    { Address: string
      City: string
      Country: string }

type Person =
    { Name: string
      Email: string
      Residences: Collections.Generic.List<Residence> }

let people = Collections.Generic.List<Person>()

let options = JsonSerializerOptions()
options.PropertyNameCaseInsensitive <- true

let appendPeople (r: HttpRequest) =
    Text.Encoding.UTF8.GetString(r.rawForm)
    |> fun x -> JsonSerializer.Deserialize<Person>(x, options)
    |> people.Add

    OK ""

let app =
    path "/"
    >=> choose [ GET
                 >=> request (fun _ -> OK(JsonSerializer.Serialize people))
                 POST >=> request appendPeople ]

[<EntryPoint>]
let main argv =
    startWebServer
        { defaultConfig with
              bindings = [ HttpBinding.createSimple HTTP "127.0.0.1" 3000 ] }
        app

    0
