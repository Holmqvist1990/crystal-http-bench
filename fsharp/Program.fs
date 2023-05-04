open System
open Suave
open Suave.Filters
open Suave.Operators
open Suave.Successful
open Utf8Json
open Utf8Json.Resolvers
open Utf8Json.FSharp
open Suave.Writers

CompositeResolver.RegisterAndSetAsDefault(FSharpResolver.Instance, StandardResolver.Default)

type Residence =
    { address: string
      city: string
      country: string }

type Person =
    { name: string
      email: string
      residences: Collections.Generic.List<Residence> }

let people = Collections.Concurrent.ConcurrentBag<Person>()

let appendPeople (r: HttpRequest) =
    Text.Encoding.UTF8.GetString(r.rawForm)
    |> fun x -> JsonSerializer.Deserialize<Person>(x)
    |> people.Add

    setHeader "Connection" "Keep-Alive" >=> OK ""

let app =
    path "/"
    >=> choose
        [ GET
          >=> request (fun _ ->
          setHeader "Connection" "Keep-Alive" >=> OK(JsonSerializer.ToJsonString people))
          POST >=> request appendPeople ]

[<EntryPoint>]
let main argv =
    startWebServer
        { defaultConfig with
            bindings = [ HttpBinding.createSimple HTTP "127.0.0.1" 3000 ] }
        app

    0
