if (Java.available){
	Java.perform(function(){
      var NetworkSecurityTrustManager = Java.use("android.security.net.config.NetworkSecurityTrustManager")

      NetworkSecurityTrustManager.checkServerTrusted.overload('[Ljava.security.cert.X509Certificate;', 'java.lang.String', 'java.net.Socket').implementation = function(a, b, c){
            // see https://android.googlesource.com/platform/frameworks/base/+/master/core/java/android/security/net/config/NetworkSecurityTrustManager.java
		  	// In case of succesfully validating the chain this method returns (return type is `void`). A failed validation throws a CertificateException.
		  	// Everything is fine by just returning, too.
            console.log("NetworkSecurityTrustManager.checkServerTrusted was ignored");
            return;
      }

      NetworkSecurityTrustManager.checkPins.implementation = function(X509CertificateList){
      	// see https://android.googlesource.com/platform/frameworks/base/+/master/core/java/android/security/net/config/NetworkSecurityTrustManager.java
      	// In case of succesfully validating the chain this method returns (return type is `void`). A failed validation throws a CertificateException.
      	// Everything is fine by just returning, too. 
      	console.log("NetworkSecurityTrustManager.checkServerTrusted just ignored");

      	return;
      };

	});
}