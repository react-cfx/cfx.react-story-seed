path = require 'path'

module.exports =
  module:
    loaders: [

        test: /\.css?$/,
        loaders: [ 'style', 'raw' ],
        include: path.resolve __dirname, '../'

      ,
        test: /\.styl$/
        loader: 'style!css!stylus-loader'

      ,
        test: /\.coffee$/
        loaders: [
          'react-hot'
          'coffee-loader'
        ]
        exclude: /node_modules/

    ]
