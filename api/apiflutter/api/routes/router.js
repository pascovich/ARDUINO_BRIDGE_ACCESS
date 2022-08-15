const router = require('express').Router();

const parametre = require('../controllers/parametre');
const historique = require('../controllers/historique');



// parametre roots
router.post('/parametre', parametre.createParametre);
router.get('/parametre',parametre.findParametre);
router.get('/parametre/single/:paramId',parametre.getSingleParametre);
router.put('/parametre/:paramId',parametre.updateParametre);
router.delete('/parametre/:paramId',parametre.deleteParametre);

// historique roots
router.post('/historique', historique.createHistorique);
router.get('/historique',historique.findHistorique);
router.get('/historique/single/:historiqueId',historique.getSingleHistorique);
router.put('/historique/:historiqueId',historique.updateHistorique);
router.delete('/historique/:historiqueId',historique.deleteHistorique);


module.exports = router;