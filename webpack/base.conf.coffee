path = require 'path'
HtmlWebpackPlugin = require 'html-webpack-plugin'
# ExtractTextPlugin = require 'extract-text-webpack-plugin'

module.exports =
  entry: './src/main.coffee'
  output:
    path: path.join __dirname, './dist'
    publicPath: '/'
    filename: 'dist/build.js'
  plugins: [
    new HtmlWebpackPlugin
      # filename: '../../index.html'
      template: path.join __dirname, '../src/index.jade'
    # new ExtractTextPlugin 'styles.css'
  ]
  # resolve:
  #   extensions:
  #     alias:
  #     src:
  module:
    loaders: [

        test: /\.jade$/
        loader: 'jade-loader'

      ,
        test: /\.less$/
        loader: 'style!css!less-loader'

      ,
        test: /\.styl$/
        loader: 'style!css!stylus-loader'

      ,
        test: /\.css$/
        loader: 'style-loader!css-loader'
        # loaders: [ 'style', 'raw' ]

      ,
        test: /\.coffee$/
        loaders: [
          'react-hot'
          'coffee-loader'
        ]
        exclude: /node_modules/

      # ,
      #   test: /\.js$/
      #   loader: 'babel!eslint'
      #   exclude: /node_modules/

      ,
        test: /\.(png|jpg|gif)$/
        loader: 'url'
        query:
          limit: 10000
          name: '[name].[ext]?[hash]'
    ]
