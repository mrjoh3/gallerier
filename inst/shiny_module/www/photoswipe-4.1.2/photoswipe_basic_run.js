
      var openPhotoSwipe = function() {

          var pswpElement = document.querySelectorAll('.pswp')[0];

          // define options (if needed)
          var options = {
              // optionName: 'option value'
              // for example:
              index: 0 // start at first slide
          };

          //var slides = HTMLWidgets.dataframeToD3(x.slides);
          var slides = [
              {"src":"https://placekitten.com/1200/900",
               "w":1200,
               "h":900},
              {"src":"https://placekitten.com/600/400",
               "w":600,
               "h":400}
            ];

          console.log(slides);

          var gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, slides, options);

          gallery.init();

      };

      openPhotoSwipe();
