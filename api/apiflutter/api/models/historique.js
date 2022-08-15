const mongoose = require('mongoose');

const schemaHistorique = mongoose.Schema(
    {
        _id: mongoose.Schema.Types.ObjectId,
        heuredate:{
            type:Date,
            default: Date.now
        },
        poids:{
            type:Number,
            require:true
        },
        decision:{
            type:String,
            require:true
        },
    }
);

module.exports = mongoose.model('Historique', schemaHistorique);