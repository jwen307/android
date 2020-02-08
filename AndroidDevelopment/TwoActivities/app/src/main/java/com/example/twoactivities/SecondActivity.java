package com.example.twoactivities;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class SecondActivity extends AppCompatActivity {
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
        //Closes the Activity and returns to MainActivity
        finish();
    }
}
