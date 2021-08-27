module main

import vweb
import json

struct App {
	vweb.Context
mut:
	people shared []Person
}

fn main() {
	vweb.run(&App{}, 3000)
}

['/'; get]
pub fn (mut app App) get() vweb.Result {
	mut pp := rlock app.people {
		app.people
	}
	return app.json(json.encode(*pp))
}

['/'; post]
pub fn (mut app App) insert() vweb.Result {
	p := json.decode(Person, app.req.data) or {
		println('ohno')
		return app.text('Failed to parse json')
	}
	lock app.people {
	app.people << p
	}
	return app.text('ok')
}

struct Person {
	name       string      
	email      string      
	residences []Residence 
}

struct Residence {
	street  string 
	city    string 
	country string 
}
