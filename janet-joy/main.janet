(use joy)

(def users @[])

(defn show [request]
  (application/json users))

(defn add [request]
  (if-let [{:body user} request]
    (do (array/push users user)
        (@{:status 201}))
    @{:status 500}))

(defroutes routes
  [:get "/" show]
  [:post "/" add])

(def app (-> (handler routes)
             (cors)
             (json-body-parser)))

(server app 3000)
