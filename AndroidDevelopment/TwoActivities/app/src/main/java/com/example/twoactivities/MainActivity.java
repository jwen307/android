package com.example.twoactivities;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private static final String LOG_TAG = MainActivity.class.getSimpleName();
    //Add the key for the bundle
    public static final String EXTRA_MESSAGE = "com.example.android.twoactivites.extra.MESSAGE";
    //Add a variable to store the EditText Message
    private EditText mMessageEditText;
    // Define the key for a particular type of response you're interested in
    public static final int TEXT_REQUEST = 1;
    //Add two variables for the reply TextViewElements
    private TextView mReplyHeadTextView;
    private TextView mReplyTextView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Get a reference to the EditText
        mMessageEditText = findViewById(R.id.editText_main);

        //Get the references for the replies
        mReplyHeadTextView = findViewById(R.id.text_header_reply);
        mReplyTextView = findViewById(R.id.text_message_reply);

        //Restore the state
        if (savedInstanceState != null){
            boolean isVisible = savedInstanceState.getBoolean("reply_visible");
            //If it's true, set the reply head to visible
            if (isVisible){
                mReplyHeadTextView.setVisibility(View.VISIBLE);
                mReplyTextView.setText(savedInstanceState.getString("reply_text"));
                mReplyTextView.setVisibility(View.VISIBLE);
            }
        }

        //Add a log statement to track when it is created
        Log.d(LOG_TAG, "_______");
        Log.d(LOG_TAG,"onCreate");
    }



    public void launchSecondActivity(View view) {
        Log.d(LOG_TAG, "Button clicked!");
        Intent intent = new Intent(this, SecondActivity.class);
        String message = mMessageEditText.getText().toString();
        intent.putExtra(EXTRA_MESSAGE,message);
        startActivityForResult(intent,TEXT_REQUEST);
    }

    //This functions sets what happens when the reply comes back
    @Override
    public void onActivityResult(int requestCode,
                                 int resultCode, Intent data) {

        //Inherit the typical onActivityResult class stuff
        super.onActivityResult(requestCode, resultCode, data);

        //Check if the request code is the same for the result coming back
        //In case you have multiple requests
        if (requestCode == TEXT_REQUEST) {
            //Makes sure the result is ok, this is set on by the second activity
            if (resultCode == RESULT_OK) {
                String reply = data.getStringExtra(SecondActivity.EXTRA_REPLY);
                //Set the visibility of the reply text head
                mReplyHeadTextView.setVisibility(View.VISIBLE);
                //Set the text for the reply message
                mReplyTextView.setText(reply);
                //Set the visibility for the reply message
                mReplyTextView.setVisibility(View.VISIBLE);
            }
        }
    }


    //Override the different states to see the transitions
    //Override onStart just to see when it move to the start state
    @Override
    public void onStart(){
        super.onStart();
        Log.d(LOG_TAG,"onStart");
    }

    @Override
    public void onPause(){
        super.onPause();
        Log.d(LOG_TAG,"onPause");
    }

    @Override
    public void onRestart(){
        super.onRestart();
        Log.d(LOG_TAG,"onRestart");
    }

    @Override
    public void onResume(){
        super.onResume();
        Log.d(LOG_TAG,"onResume");
    }

    @Override
    public void onStop(){
        super.onStop();
        Log.d(LOG_TAG,"onStop");
    }
    @Override
    public void onDestroy(){
        super.onDestroy();
        Log.d(LOG_TAG,"onDestroy");
    }

    //Save the activity state
    @Override
    public void onSaveInstanceState(Bundle outState){
        super.onSaveInstanceState(outState);

        //Check if the reply head is currently visible, if so, set it to true
        if (mReplyHeadTextView.getVisibility() == View.VISIBLE){
            outState.putBoolean("reply_visible",true);
            outState.putString("reply_text",mReplyTextView.getText().toString());
        }
    }


}
