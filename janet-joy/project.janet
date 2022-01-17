(declare-project
  :name "janet-joy"
  :description ""
  :dependencies ["https://github.com/joy-framework/joy"]
  :author "Fredrik Holmqvist"
  :license "MIT"
  :url "https://github.com/Holmqvist1990/http-json-bench")

(phony "server" []
  (if (= "development" (os/getenv "JOY_ENV"))
    (os/shell "find . -name '*.janet' | entr janet main.janet")
    (os/shell "janet main.janet")))

(declare-executable
  :name "app"
  :entry "main.janet")
