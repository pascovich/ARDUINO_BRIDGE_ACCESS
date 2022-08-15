const mongoose = require('mongoose');
const Parametre = require('../models/parametre');

exports.createParametre = (req,res,next) => {
    Parametre.find({ _id: req.body._id})
    .then(
        (result) => {
            if (result.length > 0) {
                res.status(409).json({
                    message: "Ce Parametre existe déjà"
                });
            } else{
                const newParametre = Parametre(
                    {
                        _id: new mongoose.Types.ObjectId,
                        poids: req.body.poids,
                           
                    }
                );
                newParametre.save()
                    .then(
                    (parametre) => {
                        const response = {
                            id: parametre._id,
                            poids: parametre.poids,
                                                                              
                        };
                        return res.status(200).json({
                            message: "Le Parametre a été ajoutée avec succès",
                            parametre: response,
                        })
                    }
                )
                .catch(
                    err => {
                        res.status(500).json({
                            error: err.message
                        })
                    }
                )
            }
        }
    )
    .catch(
        err => {
            res.status(500).json({
                error: err.message
            })
        }
    )
};

exports.findParametre = (req,res) => {
    
    Parametre.find((err, hist) => {
        if (err) {
            res.status(500).json({
                error: err.message
            });
        } else {
            res.status(200).json({
                parametre: hist
            }); 
        }
    });
}

exports.getSingleParametre = (req, res) => {
    Parametre.findById(req.params.paramId, (err, result) => {
        if (err) {
            res.status(500).json({
                error: err.message
            })
        } else {
            if (!result) {
                res.status(409).json({
                    message: "ce parametre n'existe pas"
                }
                );

            } else {
                res.status(200).json(
                    result
                )
            }
        }
    })
}

exports.updateParametre = (req, res) => {
    const id = req.params.paramId;
   
    Parametre.findById(req.params.paramId).then(
        (result)=>{
            if(!result){
                res.status(409).json({
                    message: "Ce Parametre n'existe pas"
                })
            }else{              
                
                const parametreToUpdate = new Parametre({
                    _id: id,
                    poids: req.body.poids,                                      
                });

                Parametre.updateOne({ _id: id }, parametreToUpdate).then(
                    (result) => {
                        Parametre.findById(id,(err,hist)=>{
                                if(err){
                                    res.status(500).json(
                                        {
                                            message:err.message,
                                        }
                                    );
                                } else{
                                    res.status(201).json({
                                        message: "Le Parametre a été modifiée avec succès",
                                        parametre: hist,
                                    })   
                                }
                            });                       
                    }
                ).catch(
                    err => {
                        res.status(500).json({
                            error: err.message
                        })
                    }
                )
            } 
        }
    ).catch(
        err => {
            res.status(500).json({
                error: err.message
            })
        }
    );    
}

exports.deleteParametre = (req,res)=>{
    const id = req.params.paramId;
    Parametre.findById(req.params.paramId).then(
        (result)=>{
            if(!result){
                res.status(409).json({
                    message: "Ce Parametre n'existe pas"
                })
            }else{
                Parametre.remove({_id: id}).then(
                    (result)=>{  
                        res.status(200).json({
                            message: "Le Parametre a été supprimée avec succès",    
                        }
                        );
                    }
                ).catch(
                    err=>{
                        res.status(500).json({
                            error:err.message
                        })
                    }
                );              
            }
        }
    ).catch(
        err=>{
            res.status(500).json({
                error:err.message
            })
        }
    )
   
}