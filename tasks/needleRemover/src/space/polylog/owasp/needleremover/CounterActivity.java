package space.polylog.owasp.needleremover;

import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import java.util.Timer;
import java.util.TimerTask;

import needleremover.R;


public class CounterActivity extends AppCompatActivity {

    private int count;
    private boolean isCounting;
    private Timer timer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_counter);
        isCounting = false;
    }

    @Override
    protected void onDestroy(){
        super.onDestroy();
        stopTimer();
    }

    public synchronized void onClickStartStop(View view) {
        Log.i(this.getClass().getName(), "Start/Stop toggle pressed");
        if (!isCounting) {
            startTimer();
        } else {
            stopTimer();
        }
    }

    private void startTimer() {
        Log.i(this.getClass().getName(), "Starting timer");

        timer = new Timer();
        TimerTask tt = getTimerTask();
        timer.scheduleAtFixedRate(tt, 0l, 300l);
        isCounting = true;
    }

    private void stopTimer() {
        if(timer != null) {
            Log.i(this.getClass().getName(), "Stopping timer");
            timer.cancel();
            isCounting = false;
            timer = null;
        }
    }

    @NonNull
    private TimerTask getTimerTask() {
        return new TimerTask() {
            @Override
            public void run() {
                runOnUiThread(
                        new Runnable() {
                            @Override
                            public void run() {
                                int noToDisplay = getCount();
                                display(noToDisplay);
                                incrementCount();
                            }
                        }
                );
            }
        };
    }

    public void onClickReset(View view) {
        resetCounter();
    }

    private int getCount() {
        return count;
    }

    private void incrementCount() {
        count++;
    }

    private void resetCounter() {
        count = 0;
    }

    private synchronized void display(Integer count) {
        Log.i(this.getClass().getName(), "Displaying: " + count.toString());

        TextView counterView = (TextView) findViewById(R.id.counterView);
        counterView.setText(count.toString());
    }

}
