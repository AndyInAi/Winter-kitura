import Kitura

let router = Router()

router.get("/") { request, response, next in
    response.send("<h1>Hello Winter! Hello Kitura!</h1>")
    next()
}

print("\nHTTP server at http://0.0.0.0:8080/\n");

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
