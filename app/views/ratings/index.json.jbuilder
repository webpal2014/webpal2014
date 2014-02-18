   if ( $("#beertable").length>0 ) {
      $.getJSON('beers.json', function (beers) {
        BEERS.list = beers;
        BEERS.sort_by_name;
        BEERS.show();
      });
    }
