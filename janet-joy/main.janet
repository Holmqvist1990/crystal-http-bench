(use joy)

(def users @[])

(defn show [request]
  (application/json users))

(defn add [request]
  (if-let [{:body user} request]
    (do (array/push users user)
        @{:status 201 :headers @{}})
    @{:status 500 :headers @{}}))

(defroutes routes
  [:get "/" show]
  [:post "/" add])

(def app (-> (handler routes)
             (json-body-parser)
             (cors)))

(defn main [& args]
  (server app 3000))
