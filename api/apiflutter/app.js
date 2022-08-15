const express = require('express');
const app = express();
const mongoose = require('mongoose');
const config = require('./configs/config');
const cors = require('cors')
const routes = require('./api/routes/router');

// connection to the server
mongoose.connection.on('connected',()=>{
    console.log("connected to server");
});
mongoose.connection.on('error',err=>{
    console.log("error at mongoDB" + err);
});

// connection to the database
mongoose.connect(config.dbUrl, {useNewUrlParser: true, useUnifiedTopology: true}, (err) => {
    if (err)
        console.error(err);
    else
        console.log("Connexion à la base de donnée"); 
});


app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: false }));


app.use((req,res,next)=>{
        res.header("Access-Control-Allow-Origin","*");
        res.header("Access-Control-Allow-Headers","Origin,X-Requested-With,Content-Type,Accept,Autorization");
    
        if(req.method === "OPTIONS"){
            res.header('Access-Control-Allow-Methods','PUT,POST,PATCH,DELETE,GET');
            res.status(200).json({});
        }
        next();
    });


// this containes all about our routes and middlewires
app.use(routes);

// handling errors
app.use((req,res,next)=>{
    const error = new Error('Not found');
    error.status = 404;
    next(error);
});

app.use((error,req,res,next)=>{
    res.status(error.status || 500).json(
        {            
            message : error.message
        }
    );
});


module.exports = app;