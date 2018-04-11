if(Java.available){
  Java.perform(function() {
      Java.enumerateLoadedClasses({
          onMatch: function(className) {
            send(className)
          },
          onComplete: function() {
            send("DONE")
          }
      });
  });
}
