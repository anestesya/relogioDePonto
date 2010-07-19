/*****
  To authorize on Twitter API through xAuth, you need HMAC-SHA1
  I'm using the following lib for that:
    http://jssha.sourceforge.net
  Make sure you have sha.js included!
  <script src="http://jssha.sourceforge.net/sha.js"></script>
  
  Also, you need to email api@twitter.com to get xAuth access
  I cannot do that for you - see http://dev.twitter.com/pages/xauth
  
  cross-domain XHRs only work on file:// protocol pages
  use PhoneGap!
*****/

// from MDC - native encodeURIComponent isn't sufficient here
window.fixedEncodeURIComponent = function (str) {  
  return encodeURIComponent(str)
            .replace(/!/g, '%21').replace(/'/g, '%27')
            .replace(/\(/g, '%28').replace(/\)/g, '%29')
            .replace(/\*/g, '%2A');  
}

// listing all members for legibility
var TwitterApiRequest = function() {
  this.nonce = this.generateNonce();
  this.timestamp = this.getUTCtimestamp();
  
  this.postBody = null;
  
  this.signature = null;
  this.signatureBaseString = null;
  
  this.token = null;
  this.tokenSecret = null;
  
  this.path = null;
}

TwitterApiRequest.prototype.generateNonce = function () {
  var nonce = [];
  var length = 5; // arbitrary - looks like a good length
  
  for (length; length > 0; length--)
    nonce.push((((1+Math.random())*0x10000)|0).toString(16).substring(1));
    
  return nonce.join("");
}

// could possibly do without UTC, but here we are
TwitterApiRequest.prototype.getUTCtimestamp = function () {
  return (new Date((new Date).toUTCString())).getTime() / 1000;
}

// don't forget trailing &!
TwitterApiRequest.prototype.consumerSecret = "MY-CONSUMER-SECRET-GOES-HERE&"

TwitterApiRequest.prototype.sigBaseTemplate = "POST&" +
  "{{ path }}&" +
  "oauth_consumer_key%3DMY-CONSUMER-KEY-GOES-HERE%26" + 
  "oauth_nonce%3D" + "{{ nonce }}" + "%26" + 
  "oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D" + "{{ time }}" + "%26" + 
  "{{ optional_token }}" +
  "oauth_version%3D1.0%26" + 
  "{{ post_body }}";
  
TwitterApiRequest.prototype.authTemplate = "OAuth " +
	"oauth_nonce=\"" + "{{ nonce }}" + "\", " +
	"oauth_signature_method=\"HMAC-SHA1\", " + 
	"oauth_timestamp=\"" + "{{ time }}" + "\", " + 
	"oauth_consumer_key=\"MY-CONSUMER-KEY-GOES-HERE\", " + 
	"{{ optional_token }}" + 
	"oauth_signature=\"" + "{{ signature }}" + "\", " + 
	"oauth_version=\"1.0\"";

TwitterApiRequest.prototype.postTarget = function () {
  return [this.path,this.postBody].join("?");
}

TwitterApiRequest.prototype.setSignature = function (secret) {
  var hmacGen = new jsSHA(this.signatureBaseString, "ASCII");
  this.signature = hmacGen.getHMAC(secret, "ASCII", "SHA-1", "B64") + "%3D";
}

TwitterApiRequest.prototype.setupBaseString = function (token) {
  var tokenReplacement = token ? "oauth_token%3D" + token + "%26" : "";
  
  this.signatureBaseString = this.sigBaseTemplate
          .split("{{ path }}").join(encodeURIComponent(this.path))
          .split("{{ optional_token }}").join(tokenReplacement)
          .split("{{ nonce }}").join(this.nonce)
          .split("{{ time }}").join(this.timestamp)
          .split("{{ post_body }}").join(encodeURIComponent(this.postBody));
}

TwitterApiRequest.prototype.setupAuthHeader = function (token) {
  var tokenReplacement = token ? "oauth_token=\"" + token + "\", " : "";
  
  this.authHeader = this.authTemplate
                      .split("{{ nonce }}").join(this.nonce)
                      .split("{{ optional_token }}").join(tokenReplacement)
                      .split("{{ time }}").join(this.timestamp)
                      .split("{{ signature }}").join(this.signature);
}

TwitterApiRequest.prototype.setUpAuthPost = function (user, pw) {
  this.path = "https://api.twitter.com/oauth/access_token";
  this.postBody = "x_auth_mode=client_auth&" +
    		          "x_auth_password=" + fixedEncodeURIComponent(pw) + "&" +
    		          "x_auth_username=" + fixedEncodeURIComponent(user);

  this.setupBaseString();
  this.setSignature(this.consumerSecret);
  this.setupAuthHeader();
  
  return true;
}

TwitterApiRequest.prototype.setUpUpdate = function (status) {
  this.path = "http://api.twitter.com/1/statuses/update.json";
  this.postBody = "status=" + fixedEncodeURIComponent(status);

  if (!this.token || !this.tokenSecret) {
    throw("Need valid OAuth token and OAuth token secret");
  }
  
  this.setupBaseString(this.token);
  this.setSignature(this.consumerSecret + this.tokenSecret);
  this.setupAuthHeader(this.token);

  return true;
}

var twitterUrl, updateUrl;

var authorizeRequest = new TwitterApiRequest();
authorizeRequest.processCredentials("USER-NAME", "USER-PASSWORD");
authorizeRequest.sign();

if (authorizeRequest.setUpAuthPost("bbletchley", "passw0rd")) {
  twitterUrl = authorizeRequest.postTarget();
} else {
  console.log("fail")
}

var req = new XMLHttpRequest();

// sync for testing purposes, not required
req.open('POST', twitterUrl, false);
req.setRequestHeader("Authorization", authorizeRequest.authHeader);
req.send();

// should be 200
console.log(req.status);

// should look like:
// oauth_token=HERE-IS-MY-AWESOME-TOKEN&oauth_token_secret=THIS-IS-MY-TOKEN-SECRET&
// user_id=007&screen_name=JamesBond&x_auth_expires=0
console.log(req.responseText);

var vals = req.responseText.split("&");
var oauthFields = {};
  
vals.forEach(function (field) {
  oauthFields[field.split("=")[0]] = field.split("=")[1];
});

var postRequest = new TwitterApiRequest();
postRequest.token = oauthFields.oauth_token;
postRequest.tokenSecret = oauthFields.oauth_token_secret;

if (postRequest.setUpUpdate("Here is my inane new update!")) {
  updateUrl = postRequest.postTarget();
}

var req2 = new XMLHttpRequest();
req2.open('POST', updateUrl, false);
req2.setRequestHeader("Authorization", postRequest.authHeader);
req2.send();

console.log(req2.status);
console.log(req2.responseText);