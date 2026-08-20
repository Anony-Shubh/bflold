<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    <title>Document</title>
  </head>
  <body>
    <div
      class="catalog-app"
      style="background-color: rgb(237, 203, 158) !important"
    >
      <div id="viewer">
        <div id="flipbook" class="ui-flipbook">
          <!-- Do not place the content here -->
          <a ignore="1" class="ui-arrow-control ui-arrow-next-page"></a>
          <a ignore="1" class="ui-arrow-control ui-arrow-previous-page"></a>
        </div>
      </div>

      <!-- controls -->
      <div id="controls">
        <div class="all">
          <div class="ui-slider" id="page-slider">
            <div class="bar">
              <div class="progress-width">
                <div class="progress">
                  <div class="handler"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="ui-options" id="options">
            <!-- <a class="ui-icon" id="ui-icon-table-contents">
              <i class="fa fa-bars"></i>
            </a> -->
            <a
              class="ui-icon show-hint"
              title="Miniatures"
              id="ui-icon-miniature"
            >
              <i class="fa fa-th"></i>
            </a>
            <a class="ui-icon" id="ui-icon-zoom">
              <i class="fa fa-file-o"></i>
            </a>
            <a class="ui-icon show-hint" title="Share" id="ui-icon-share">
              <i class="fa fa-share"></i>
            </a>
            <a
              class="ui-icon show-hint"
              title="Full Screen"
              id="ui-icon-full-screen"
            >
              <i class="fa fa-expand"></i>
            </a>
            <a class="ui-icon show-hint" id="ui-icon-toggle">
              <i class="fa fa-ellipsis-v"></i>
            </a>
          </div>

          <!-- zoom slider -->
          <div id="zoom-slider-view" class="zoom-slider">
            <div class="bg">
              <div class="ui-slider" id="zoom-slider">
                <div class="bar">
                  <div class="progress-width">
                    <div class="progress">
                      <div class="handler"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- / zoom slider -->
        </div>

        <div id="ui-icon-expand-options">
          <a class="ui-icon show-hint">
            <i class="fa fa-ellipsis-h"></i>
          </a>
        </div>
      </div>
      <!-- / controls -->

      <!-- miniatures -->
      <div id="miniatures" class="ui-miniatures-slider"></div>
      <!-- / miniatures -->
    </div>
    <div class="flip">
      <div class="text-flip">Click here to flip</div>
      <div class="flip-here">
        <img src="img/arrow.png" style="width: 40px" />
      </div>
    </div>
    <script src="https://code.jquery.com/jquery-2.0.3.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore-min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.4.0/backbone-min.js"></script>
    <script src="js/script.js"></script>
    <script>
      // shim layer with setTimeout fallback
      window.requestAnimFrame = (function () {
        return function (callback) {
          window.setTimeout(callback, 1000);
        };
      })();

      $(document).ready(function () {
        $(".page").on("click", function (e) {
          $(this).toggleClass("open");

          e.preventDefault();
        });

        var $shadow = $(".page");
        var moveEvent =
          "ontouchstart" in document.documentElement
            ? "touchmove"
            : "mousemove";

        (function animloop() {
          requestAnimFrame(animloop);

          $(window).bind(moveEvent, function (ev) {
            var $this = $(this);
            var w = $this.width();
            var h = $this.height();
            var center = { x: w / 2, y: h / 2 };

            var evX =
              moveEvent == "touchmove"
                ? ev.originalEvent.touches[0].clientX
                : ev.clientX;
            var evY =
              moveEvent == "touchmove"
                ? ev.originalEvent.touches[0].clientY
                : ev.clientY;

            var shadowX = ((evX / w) * 40 - 20) * -1;
            var shadowY = ((evY / h) * 40 - 20) * -1;

            $shadow.css({
              boxShadow: shadowX + "px " + shadowY + "px 25px rgba(0,0,0,.35)",
            });
          });
        })();
      });
    </script>
  </body>
</html>
