path = require 'path'

module.exports =
  module:
    loaders: [
        test: /\.css?$/,
        loaders: [ 'style', 'raw' ],
        include: path.resolve __dirname, '../'
      ,
        test: /\.coffee$/
        loaders: [
          'react-hot'
          'coffee-loader'
        ]
        exclude: /node_modules/
    ]
