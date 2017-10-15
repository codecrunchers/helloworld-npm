var GREETING = process.env.GREETING || "No Greeting Set for this Env"
var http = require("http")
http.createServer(function (req, res) {
	res.writeHead(200, {"Content-Type": "text/plain"})
	res.end(GREETING)
}).listen(8000)
