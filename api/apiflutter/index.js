require ('dotenv').config();
const http = require('http');
const app = require('./app');

const port = process.env.PORT || 8000;
const server = http.createServer(app);

server.listen(port, () => {
    console.log(`Server listening on port: ${port}`);
});