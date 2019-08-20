document.getElementById('submit-btn').addEventListener('click', function (e) {
  // do some validation
  if(isValid) {
    // call reCAPTCHA check
    grecaptcha.execute();
  }
});

var submitInvisibleRecaptchaForm = function () {
  document.getElementById("invisible-recaptcha-form").submit();
};
