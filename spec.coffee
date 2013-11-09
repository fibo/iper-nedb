
DataStore = require('nedb')
iper      = require('iper')
IperNeDB  = require('./index')
should    = require('should')

db = new IperNeDB()

IperGraph = iper.IperGraph

graph = new IperGraph()

graph.createNode('foo')
graph.createNode('bar')

describe 'IperNeDB', ->
  describe 'Inheritance', ->
    it 'is a nedb DataStore', ->
      db.should.be.instanceOf DataStore

  describe 'Methods', ->
    describe '#insertGraph()', ->
      it 'has signature (graph)', ->
        db.insertGraph(graph)

      it 'does not insert duplicates', ->
        db.insertGraph(graph) # again

        db.find({}, (err, docs) ->
          docs.length.should.be.eql 1
        )

      it 'throws error if graph is not an IperGraph', ->
        (() ->
          db.insertGraph('not an IperGraph')
        ).should.throwError()

      it 'stores id', ->
        db.findOne( {id: graph.id}, (err, doc) ->
          graph.data.should.be.eql doc.data
        )

    describe '#findOneGraph()', ->
      it 'has signature (graph, callback)', ->
        db.findOneGraph(graph, (err, doc) ->
          graph.data.should.be.eql doc.data
        )

      it 'throws error if graph is not an IperGraph', ->
        (() ->
          db.findOneGraph('not an IperGraph')
        ).should.throwError()

      it 'throws error if callback is not a function', ->
        (() ->
          db.findOneGraph(graph, 'not a function')
        ).should.throwError()

    describe '#updateGraph()', ->
      it 'has signature (graph)', ->
        graph.createNode('quz')

        db.updateGraph(graph)

        db.findOneGraph(graph, (err, doc) ->
          graph.data.should.be.eql doc.data
        )

      it 'throws error if graph is not an IperGraph', ->
        (() ->
          db.updateGraph('not an IperGraph')
        ).should.throwError()

    describe '#removeGraph()', ->
      it 'has signature (graph)', ->
        db.removeGraph(graph)

        db.findOne( {id: graph.id}, (err, doc) ->
          should.strictEqual(null, doc)
        )

      it 'throws error if graph is not an IperGraph', ->
        (() ->
          db.removeGraph('not an IperGraph')
        ).should.throwError()

