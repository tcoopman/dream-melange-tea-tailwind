let home = {
  <html>
    <head>
      <link href="/static/index.css" rel="stylesheet">
    </head>
    <body>
      <script src="/static/index.js"></script>
    </body>
  </html>
};

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router([

    Dream.get("/",
      (_ => Dream.html(home))),

    Dream.get("/static/**",
      Dream.static("./static")),

  ])
  @@ Dream.not_found;
