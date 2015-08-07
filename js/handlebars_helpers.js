Handlebars.registerHelper('currency', function(amount) {
  amount = parseFloat(amount);
  if(amount === 0.0){
    return "-";
  }else{
    return numeral(amount).format('$0,0.00');
  }
});

Handlebars.registerHelper('gravatar', function(context, options) {
  var email = context;
  var size=( typeof(options.hash.size) === "undefined") ? 32 : options.hash.size;

  return "http://www.gravatar.com/avatar/" + md5(email) + "?s="+ size;
});

Handlebars.registerHelper('googlemap', function(context, options) {
  var address = context;
  var scale   = (typeof(options.hash.scale) === "undefined") ? 2 : options.hash.scale;
  var zoom    = (typeof(options.hash.zoom) === "undefined") ? 13 : options.hash.zoom;
  var width = 600;
  var height = 300;

  return "https://maps.googleapis.com/maps/api/staticmap?" +
    "scale=" + scale +
    "&zoom=" + zoom +
    "&size=" + width + "x" + height +
    "&maptype=roadmap" +
    "&markers=" + encodeURIComponent("1302 Waugh Dr #212, Houston, TX 77019");
});
