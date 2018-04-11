'use strict;'
// Start with checking if a Java environment is available
if (Java.available) {

    // all Java handling needs to happen inside a function passed to Java.perform()
    Java.perform(function() {

      // JS wrappers for Java classes
      const JavaStringClass = Java.use('java.lang.String');
      const TextActivity = Java.use("space.polylog.owasp.needleremover.TextActivity");

      // overwrite the method responsible for setting the text which will be displayed
      TextActivity.setPanelContent.implementation = function(newContent) {
        // send the argument that the method originally received to the python module
        send(newContent);

        // declare variable for the response
        var user_defined_content = "DEFAULT";


        /*
          See the docs about the message passing: https://www.frida.re/docs/messages/
          `recv` provides an asynchronous mechanism to handle messages from the controller side.
          Remember: messages are JSON strings of the format {u'type': '<Some Type>', <other attributes>}.
          In our case: 
            {'type': 'input', 'payload': <user_content>}
          The first argument is the `type` this recv-instance is waiting for,
          and the second argument is a function that is invoked with the
          received JSON content
        */
        var op = recv('input', function onMessage(value) {
            user_defined_content = value.payload;
          }
        );
        // block until an answer arrives
        op.wait();

        // Create a java.lang.String instance with the new content
        var jstring = JavaStringClass.$new(user_defined_content);
        // and pass it to the original implementation of the method
        this.setPanelContent(jstring);
      }
    }
  )
}