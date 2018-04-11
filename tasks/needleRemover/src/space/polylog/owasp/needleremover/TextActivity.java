package space.polylog.owasp.needleremover;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import needleremover.R;

public class TextActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_text);
    }

    private void setPanelContent(String new_content){
        TextView simpleTextView = (TextView)findViewById(R.id.textView);
            simpleTextView.setText(new_content);
    }

    public void setTextOnClick(View view) {
        EditText editField = (EditText) findViewById(R.id.editText);
        setPanelContent(editField.getText().toString());
    }
}
