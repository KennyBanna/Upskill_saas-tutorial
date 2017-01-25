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
    submitBtn.val("Processing").prop('disabled', true);
    
    //Collect credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    
    //Use stripe js library to validate credit card fields
    var error = false; 
    
    //Validate card fields
    if (!Stripe.card.validateCardNumber(ccNum)){
      error == true;
      alert('The credit card number seems to be invalid');
    }
    
    if (!Stripe.card.validateCVC(cvcNum)){
      error == true;
      alert('The credit CVC number seems to be invalid');
    }
    
    if (!Stripe.card.validateExpiry(expMonth, expYear)){
      error == true;
      alert('The expiration date seems to be invalid');
    }
    
    if (error) {
      //dont send to stripe 
      //Re-enable the button
      submitBtn.val('Sign up').prop('disabled', false)
    }
    else{
      //Send Card info to stripe
      Stripe.createToken({
      number: ccNum,
      cvc: cvcNum,
      exp_month: expMonth,
      exp_year: expYear
      }, stripeResponseHandler);
    }
    
  });
  
  //Stripe returns back a card token
  function stripeResponseHandler(status, response){
    //get token from response
    var token = response.id;
  
    //inject token into form as hidden field
    theForm.append($('<input-type="hidden" name="user[stripe_card_token]">').val(token) );
  
    //Submit form to Rails app
    theForm.get(0).submit(); //0 because it's the first in an array
    
    return false;
  }
});