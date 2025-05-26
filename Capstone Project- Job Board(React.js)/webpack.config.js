module: {
  rules: [
    {
      test: /.jsx?$/,
      loader: 'babel-loader',
      include: path.join(__dirname, 'src'),
      exclude: /node_modules/
    }
  ]
}