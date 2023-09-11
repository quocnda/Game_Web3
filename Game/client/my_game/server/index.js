const express = require("express")
const app = express()
const http = require("http")
const {Server} = require("socket.io")
const cors = require("cors")
app.use(cors())
const server = http.createServer(app)

const io = new Server(server , {
    cors : {
        origin: "http://localhost:3001",
        methods: ["GET","POST"]
    }
})
io.on("connection" , (socket) => {
    console.log("User connected " , socket.id)
    socket.on("send_mess" , (data) => {
        console.log(data)
        socket.broadcast.emit("recieve_mess",data)
    })
    
})
server.listen(3000,() => {
    console.log("server is running")
})