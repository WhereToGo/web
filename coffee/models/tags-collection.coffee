define [
  'chaplin',
  'models/base/collection'
  'models/base/model'
], (Chaplin, Collection, Model) ->
  'use strict'

  class TagsModel extends Model
    idAttribute: "int_id"
  

  class TagsCollection extends Collection
    url: "/api/tags/getall"
    model: TagsModel
