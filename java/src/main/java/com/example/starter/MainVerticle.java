package com.example.starter;

import java.util.ArrayList;
import java.util.concurrent.CopyOnWriteArrayList;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Promise;
import io.vertx.core.http.HttpMethod;
import io.vertx.ext.web.Router;

class Person {
  public String Name;
  public String Email;

  @JsonManagedReference
  public ArrayList<Residence> Residences;

  @JsonCreator
  public Person(@JsonProperty("name") String name, @JsonProperty("email") String email,
      @JsonProperty("residences") ArrayList<Residence> recidences) {
    this.Name = name;
    this.Email = email;
    this.Residences = recidences;
  }
}

class Residence {
  public String Street;
  public String City;
  public String Country;

  @JsonCreator
  public Residence(
      @JsonProperty("Street") String street,
      @JsonProperty("City") String city,
      @JsonProperty("Country") String country) {
    this.Street = street;
    this.City = city;
    this.Country = country;
  }
}

public class MainVerticle extends AbstractVerticle {
  @Override
  public void start(Promise<Void> startPromise) throws Exception {
    var server = vertx.createHttpServer();
    var router = Router.router(vertx);

    var people = new CopyOnWriteArrayList<Person>();

    router.get("/").handler(routingContext -> {
      var response = routingContext.response();
      response.putHeader("content-type", "application/json");

      try {
        response.end(new ObjectMapper().writeValueAsString(people));
      } catch (Exception e) {
        response.setStatusCode(500).end(e.getMessage());
      }
    });

    router.route(HttpMethod.POST, "/person").handler(routingContext -> {
      var request = routingContext.request();
      var response = routingContext.response();
      response.putHeader("content-type", "application/json");

      request.bodyHandler(bodyHandler -> {
        try {
          var objectMapper = new ObjectMapper();
          var newPerson = objectMapper.readValue(bodyHandler.toString(), Person.class);
          people.add(newPerson);
          response.end(objectMapper.writeValueAsString(newPerson));
        } catch (Exception e) {
          response.setStatusCode(500).end(e.getMessage());
        }
      });
    });

    server.requestHandler(router).listen(8080);
  }
}
