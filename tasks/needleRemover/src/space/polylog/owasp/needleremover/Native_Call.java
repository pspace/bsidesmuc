package space.polylog.owasp.needleremover;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import needleremover.R;

public class Native_Call extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_native__call);
    }

    /**
     * A native method that is implemented by the 'native-lib' native library,
     * which is packaged with this application.
     */
    public native String stringFromJNI();

    public void doNativeThing(View view) {
        TextView tv = (TextView) findViewById(R.id.nativeView);
        tv.setText(stringFromJNI());
    }
}
