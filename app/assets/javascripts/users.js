/* global $, Stripe */
//Document ready.
$(document).on('turbolinks:load', function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-submit-button');
  
  //Set stripe public key.
  Stripe.setPublishableKey( $('meta[name= "stripe-key"]').attr('content') );
  
  //When user clicks form-submit btn.
  submitBtn.click(function(event){
    //prevent the default submission behaviour.
    event.preventDefault();
    //Collect credit card fields.
    var ccNum = $('#card_number').val(),
        cvvNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    //Send Card info to stripe
    Stripe.createToken({
      number: ccNum,
      cvc: cvvNum,
      exp_month: expMonth,
      exp_year: expYear
    }, stripeResponseHandler);
  });
  
  //Stripe returns back a card token
  //inject token into form as hidden field
  //Submit form to Rails app
});