const mongoose = require('mongoose');
const Historique = require('../models/historique');

exports.createHistorique = (req, res) => {
    Historique.find({ _id: req.body._id })
        .then(
            (result) => {
                if (result.length > 0) {
                    res.status(409).json({
                        message: "Cet historique existe déjà"
                    });
                } else {
                    const newHistorique = Historique(
                        {
                            _id: new mongoose.Types.ObjectId,
                            poids: req.body.poids,
                            decision: req.body.decision,
                        }
                    );
                    newHistorique.save()
                        .then(
                            (historique) => {
                                const response = {
                                    id: historique._id,
                                    poids: historique.poids,
                                    decision: historique.decision,
                                };
                                return res.status(200).json({
                                    message: "L'historique a été ajoutée avec succès",
                                    historique: response,
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

exports.findHistorique = (req, res) => {

    Historique.find((err, hist) => {
        if (err) {
            res.status(500).json({
                error: err.message
            });
        } else {
            res.status(200).json({
                historique: hist
            });
        }
    });
}

exports.getSingleHistorique = (req, res) => {
    Historique.findById(req.params.historiqueId, (err, result) => {
        if (err) {
            res.status(500).json({
                error: err.message
            })
        } else {
            if (!result) {
                res.status(409).json({
                    message: "cet historique n'existe pas"
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

exports.updateHistorique = (req, res) => {
    const id = req.params.historiqueId;

    Historique.findById(req.params.historiqueId).then(
        (result) => {
            if (!result) {
                res.status(409).json({
                    message: "Cet historique n'existe pas"
                })
            } else {

                const historiqueToUpdate = new Historique({
                    _id: id,
                    poids: req.body.poids,
                    decision: req.body.decision,
                });

                Historique.updateOne({ _id: id }, historiqueToUpdate).then(
                    (result) => {
                        Historique.findById(id, (err, hist) => {
                            if (err) {
                                res.status(500).json(
                                    {
                                        message: err.message,
                                    }
                                );
                            } else {
                                res.status(201).json({
                                    message: "L'historique a été modifiée avec succès",
                                    historique: hist,
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

exports.deleteHistorique = (req, res) => {
    const id = req.params.historiqueId;
    Historique.findById(req.params.historiqueId).then(
        (result) => {
            if (!result) {
                res.status(409).json({
                    message: "Cet historique n'existe pas"
                })
            } else {
                Historique.remove({ _id: id }).then(
                    (result) => {
                        res.status(200).json({
                            message: "L'historique a été supprimée avec succès",
                        }
                        );
                    }
                ).catch(
                    err => {
                        res.status(500).json({
                            error: err.message
                        })
                    }
                );
            }
        }
    ).catch(
        err => {
            res.status(500).json({
                error: err.message
            })
        }
    )

}