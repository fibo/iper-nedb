
var DataStore = require('nedb')
  , iper      = require('iper')
  , inherits  = require('inherits')

var IperGraph = iper.IperGraph

function IperNeDB () {
  DataStore.apply(this, arguments)
}

inherits(IperNeDB, DataStore)

function insertGraph (graph) {
  if (! (graph instanceof IperGraph))
    throw new TypeError()

  var self = this
    , query = {id: graph.id}
    , graphDoc = {
        id  : graph.id,
        data: graph.data
      }

  this.findOne(query, function (err, doc) {
    if (doc === null)
      self.insert(graphDoc)
  })

}
IperNeDB.prototype.insertGraph = insertGraph

function findOneGraph (graph, callback) {
  if (! (graph instanceof IperGraph))
    throw new TypeError()

  if (typeof callback !== 'function')
    throw new TypeError()

  var query = {id: graph.id}

  this.findOne(query, callback)
}
IperNeDB.prototype.findOneGraph = findOneGraph

function updateGraph (graph) {
  if (! (graph instanceof IperGraph))
    throw new TypeError()

    var query = {id: graph.id}
    , graphDoc = {
        id  : graph.id,
        data: graph.data
      }
    , options = {
        multi : false,
        upsert: false
    }

  this.update(query, graphDoc, options)
}
IperNeDB.prototype.updateGraph = updateGraph

function removeGraph (graph) {
  if (! (graph instanceof IperGraph))
    throw new TypeError()

  var query = {id: graph.id}

  this.remove(query)
}
IperNeDB.prototype.removeGraph = removeGraph

module.exports = IperNeDB

