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

  return encode(input, signature);
}

WebToken.verify = function(wt, publicKey) {
  const key = ec.keyFromPublic(publicKey, 'hex');
  const { payload, signature } = decode(wt);

  key.verify(payload, signature);
}

WebToken.payload = function(wt) {
  return denormalizeInput(decodePayload(wt.split('.')[0]));
}

// encode

function encode(payload, signature) {
  return encodePayload(payload) + '.' + encodeSignature(signature);
}

function encodeSignature(signature) {
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

function encodePayload(payload) {
  return base64url(payload);
}

// decode

function decode(wt) {
  var decoded = {
    payload: decodePayload(wt.split('.')[0]),
    signature: decodeSignature(wt.split('.')[1])
  };

  return decoded;
}

function decodeSignature(signature) {
  return base64url.decode(signature);
}

function decodePayload(payload) {
  return base64url.decode(payload);
}

// normalization

function normalizeInput(thing) {
  return JSON.stringify(thing);
}

function denormalizeInput(thing) {
  return JSON.parse(thing);
}
