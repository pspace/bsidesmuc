Java.perform(function(){
      var ANDROID_VERSION_M = 23;

      var NetworkSecurityConfig = Java.use("android.security.net.config.NetworkSecurityConfig");

      NetworkSecurityConfig.getDefaultBuilder.overload("int").implementation = function(targetSdkVersion){
             console.log("[+] getDefaultBuilder original targetSdkVersion => " + targetSdkVersion.toString());
             return this.getDefaultBuilder.overload("int").call(this, ANDROID_VERSION_M);
      };

});
