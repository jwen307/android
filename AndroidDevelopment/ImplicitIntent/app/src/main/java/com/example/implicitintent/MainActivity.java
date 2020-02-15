package com.example.implicitintent;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ShareCompat;

public class MainActivity extends AppCompatActivity {


    private EditText mWebsiteEditText;
    private EditText mLocationEditText;
    private EditText mShareTextEditText;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Assign the EditText for the website
        mWebsiteEditText = findViewById(R.id.website_edittext);

        //Assign the EditText for the location
        mLocationEditText = findViewById(R.id.location_edittext);

        //Assign the EditText for the share text
        mShareTextEditText = findViewById(R.id.share_edittext);
    }

    public void openWebsite(View view) {
        String url = mWebsiteEditText.getText().toString();

        //Encode and parse the string into a Uri (Uniform Resource Identifier) object
        Uri webpage = Uri.parse(url);

        //Specify and implicit intent (Intent.ACTION_VIEW is an action to view the webpage)
        Intent intent = new Intent(Intent.ACTION_VIEW, webpage);

        //Find an activity that can handle the intent
        if (intent.resolveActivity(getPackageManager()) != null) {
            startActivity(intent);      //Sends the Intent
        }
        else{
            Log.d("ImplicitIntents", "Can't handle this!");   //Log in case Intent can be resolved
        }
    }

    public void openLocation(View view) {
        String loc = mLocationEditText.getText().toString();

        //Make it into a geo URI
        Uri addressUri = Uri.parse("geo:0,0?q=" + loc);

        //Create a new intent
        Intent intent = new Intent(Intent.ACTION_VIEW, addressUri);

        if (intent.resolveActivity(getPackageManager()) != null) {
            startActivity(intent);
        } else {
            Log.d("ImplicitIntents", "Can't handle this intent!");
        }
    }

    public void shareText(View view) {
        String txt = mShareTextEditText.getText().toString();

        //Define the mimeType
        String mimeType = "text/plain";


        //Call the ShareCompat.IntentBuilder
        ShareCompat.IntentBuilder
                .from(this)
                .setType(mimeType)
                .setChooserTitle(getString(R.string.chooser_title))
                .setText(txt)
                .startChooser();


    }
}
