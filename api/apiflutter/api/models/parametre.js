const mongoose = require('mongoose');

const schemaParametre = mongoose.Schema(
    {
        _id: mongoose.Schema.Types.ObjectId,       
        poids:{
            type:Number,
            require:true
        }, 
        dateoperation:{
            type:Date,
            default: Date.now
        },      
    }
);

module.exports = mongoose.model('Parametre', schemaParametre);