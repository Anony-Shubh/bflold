<head>
  <link rel="stylesheet" href="css/index.css" />

  <script>
    paceOptions = {
      elements: false
    };
  </script>
  <script src="js/pace.min.js"></script>
  <script>
    function load(time){
      var x = new XMLHttpRequest()
      x.open('GET', "http://localhost:8080/" + time, true);
      x.send();
    };

    load(20);
    load(100);
    load(500);
    load(2000);
    load(3000);

    setTimeout(function(){
      Pace.ignore(function(){
        load(3100);
      });
    }, 4000);

  </script>
</head>
<body>

this is test
</body>
