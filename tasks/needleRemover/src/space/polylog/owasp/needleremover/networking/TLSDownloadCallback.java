package space.polylog.owasp.needleremover.networking;

import android.net.NetworkInfo;

import java.security.cert.Certificate;

public interface TLSDownloadCallback {
    enum  Progress {
        ERROR(-1),
        CONNECT_SUCCESS(0),
        GET_INPUT_STREAM_SUCCESS(1),
         PROCESS_INPUT_STREAM_IN_PROGRESS(2),
         PROCESS_INPUT_STREAM_SUCCESS(3);

        private int status;
        Progress(int i){
            status = i;
        }
    }

    /**
     * Indicates that the callback handler needs to update its appearance or information based on
     * the result of the task. Expected to be called from the main thread.
     */
    void updateFromDownload(String result);

    /**
     * Get the device's active network status in the form of a NetworkInfo object.
     */
    NetworkInfo getActiveNetworkInfo();

    /**
     * Indicate to callback handler any progress update.
     * @param progress must be one of the constants defined in DownloadCallback.Progress.
     * @param percentComplete must be 0-100.
     */
    void onProgressUpdate(Progress progress, int percentComplete);

    /**
     * Indicates that the download operation has finished. This method is called even if the
     * download hasn't completed successfully.
     */
    void finishDownloading();

    void updateCertificateInfo(Certificate[] certificates);
}
