package com.example.implicitintentsreceiver;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Get the incoming intent that was used to activate the Activity
        Intent intent = getIntent();

        //Get the intent data
        Uri uri = intent.getData();

        //Make sure the uri is not empty
        if (uri != null)
        {
            String uri_string = getString(R.string.uri_label) + uri.toString();
            //Get the textView block
            TextView textView = findViewById(R.id.text_uri_message);
            //Set the textView to the uri string
            textView.setText(uri_string);
        }
    }
}
