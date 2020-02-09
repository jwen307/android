package com.example.twoactivities;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class SecondActivity extends AppCompatActivity {
    private static final String LOG_TAG = SecondActivity.class.getSimpleName();


    //Create a key for the reply
    public static final String EXTRA_REPLY =
            "com.example.android.twoactivities.extra.REPLY";

    //Variable for the reply
    private EditText mReply;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        //Set the reply to the editText_second
        mReply = findViewById(R.id.editText_second);

        //Get the Intent that activated this Activity
        Intent intent = getIntent();

        //Get the string message
        String message = intent.getStringExtra(MainActivity.EXTRA_MESSAGE);
        TextView textView = findViewById(R.id.text_message);
        textView.setText(message);
    }

    public void returnReply(View view) {
        //Get the text for the reply and set it as a string
        String reply = mReply.getText().toString();
        //Create a new intent for the reply
        Intent replyIntent = new Intent();
        //Add an extra to the intent
        replyIntent.putExtra(EXTRA_REPLY, reply);
        //Set the result to ok
        setResult(RESULT_OK,replyIntent);
        Log.d(LOG_TAG,"End SecondActivity");
        //Closes the Activity and returns to MainActivity
        finish();
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

}
