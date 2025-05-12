// functions/index.js o index.ts
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const stripe = require('stripe')(
  'sk_test_51RMP5n2euRDOKVU12HPmF89zjRIQW4bt2S0KwZSfLbUtMw8YAMm4onBv1H8r94aToERKWyCnnxfiAyNpnfLXZmGU00LmyLLwCd'
); // Test key

admin.initializeApp();

exports.createPaymentIntent = functions.https.onRequest(async (req, res) => {
  const stripe = require('stripe')(
    'sk_test_51RMP5n2euRDOKVU12HPmF89zjRIQW4bt2S0KwZSfLbUtMw8YAMm4onBv1H8r94aToERKWyCnnxfiAyNpnfLXZmGU00LmyLLwCd'
  );
  try {
    const { amount } = req.body;
    const paymentIntent = await stripe.paymentIntents.create({
      amount,
      currency: 'mxn',
      automatic_payment_methods: { enabled: true },
    });
    res.send({ clientSecret: paymentIntent.client_secret });
  } catch (err) {
    res.status(500).send({ error: err.message });
  }
});
