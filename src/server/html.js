module.exports.renderIndex = () =>
  `
  <html>
    <head>
      <meta charset="utf-8" />
      <title>Elm template</title>
      <link rel="icon" type="image/x-icon" href="/favicon.ico">
      <link rel="stylesheet" href="/font-awesome.min.css">
    </head>
    <body>
      <div id="main"></div>
      <script src="/dist/main.js"></script>
    </body>
  </html>
  `
