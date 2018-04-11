package space.polylog.owasp.needleremover;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import java.security.cert.Certificate;
import java.security.cert.X509Certificate;

import needleremover.R;
import space.polylog.owasp.needleremover.networking.NetworkFragment;
import space.polylog.owasp.needleremover.networking.TLSDownloadCallback;


public class SSLActivity extends AppCompatActivity implements TLSDownloadCallback {
    private static final String TAG = "needleREmover.TLS";

    // Keep a reference to the NetworkFragment, which owns the AsyncTask object
    // that is used to execute network ops.
    private NetworkFragment mNetworkFragment;

    // Boolean telling us whether a download is in progress, so we don't trigger overlapping
    // downloads with consecutive button clicks.
    private boolean mDownloading = false;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ssl);
        mNetworkFragment = NetworkFragment.getInstance(getSupportFragmentManager());

    }

    public void onGetClick(View view) {
        EditText urlView = (EditText) findViewById(R.id.url);
        Editable urlViewText = urlView.getText();
        downloadURL(urlViewText.toString());
    }

    private void downloadURL(String address) {

        if (!mDownloading && mNetworkFragment != null) {
            // Execute the async download.
            mNetworkFragment.startDownload(address);
            mDownloading = true;
        }

    }

    @Override
    public void updateFromDownload(String result) {
        TextView downloadContentView = (TextView) findViewById(R.id.contentView);
        downloadContentView.setText(result);
    }

    @Override
    public NetworkInfo getActiveNetworkInfo() {
        ConnectivityManager connectivityManager =
                (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connectivityManager.getActiveNetworkInfo();
        return networkInfo;
    }

    @Override
    public void onProgressUpdate(Progress progressCode, int percentComplete) {
        Log.d(TAG, progressCode.name());
    }

    @Override
    public void finishDownloading() {
        mDownloading = false;
        if (mNetworkFragment != null) {
            mNetworkFragment.cancelDownload();
        }
    }

    @Override
    public void updateCertificateInfo(Certificate[] certificates) {

        StringBuilder infoBuilder = new StringBuilder();
        infoBuilder.append("Certificates:\n");
        if (certificates != null) {
            for (Certificate cert : certificates) {
                infoBuilder.append(String.format("Certificate %s:\n", cert.getType()));

                if ("X.509".equals(cert.getType())) {
                    X509Certificate x509Certificate = (X509Certificate) cert;
                    infoBuilder.append(String.format("DN name: %s\n", x509Certificate.getIssuerDN().getName()));
                    infoBuilder.append(String.format("Serial number: %s\n", x509Certificate.getSerialNumber().toString(16)));
                }
                infoBuilder.append("\n");
            }
        } else {
            infoBuilder.append("No certificates reported!");
        }

        Log.d(TAG, infoBuilder.toString());
        TextView downloadContentView = (TextView) findViewById(R.id.certificateView);
        downloadContentView.setText(infoBuilder.toString());
    }

}