var WebToken = module.exports;

const base64url = require('base64url');
const EC = require('elliptic').ec;
const ec = new EC('secp256k1');


WebToken.genKeyPair = function() {
  const keyPair = ec.genKeyPair();

  return {
    getPrivate: function()
    {
      return keyPair.getPrivate('hex');
    },

    getPublic: function()
    {
      return keyPair.getPublic('hex');
    }
  }
}

WebToken.sign = function(payload, privateKey, exp) {
  payload['iat'] = Date.now();
  payload['exp'] = Date.now()+exp*1000;
  const input = normalizeInput(payload);
  const key = ec.keyFromPrivate(privateKey, 'hex');
  const signature = key.sign(input);

  return WebToken.encode(input, signature);
}

WebToken.verify = function(wt, publicKey) {
  const key = ec.keyFromPublic(publicKey, 'hex');
  const { payload, signature } = WebToken.decode(wt);
  var valid = false;

  try {
    valid = key.verify(payload, signature);
  } catch(err) {
    console.log(err);
  }

  return valid;
}

// encode

WebToken.encode = function(payload, signature) {
  return WebToken.encodePayload(payload) + '.' + WebToken.encodeSignature(signature);
}

WebToken.encodeSignature = function(signature) {
  var hexArray = signature.toDER().map(function(item) {
    var hex = item.toString(16);
    if(hex.length < 2) {
      hex = '0' + hex;
    }

    return hex;
  });

  var hexString = hexArray.reduce(function(prev, cur) {
    return prev + cur;
  });

  return base64url(hexString);
}

WebToken.encodePayload = function(payload) {
  return base64url(payload);
}

// decode

WebToken.decode = function(wt) {
  var decoded = {};
  decoded.payload = WebToken.decodePayload(wt.split('.')[0]);
  decoded.signature = WebToken.decodeSignature(wt.split('.')[1]);

  return decoded;
}

WebToken.decodeSignature = function(signature) {
  return base64url.decode(signature);
}

WebToken.decodePayload = function(payload) {
  return base64url.decode(payload);
}

function normalizeInput(thing) {
   return JSON.stringify(thing);
}
