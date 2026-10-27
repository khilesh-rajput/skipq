import 'dotenv/config';
export const env={port:+(process.env.PORT||4000),clientOrigin:process.env.CLIENT_ORIGIN||'http://localhost:5173',jwtSecret:process.env.JWT_SECRET||'',jwtExpiresIn:process.env.JWT_EXPIRES_IN||'8h',paymentMode:process.env.PAYMENT_MODE||'mock',razorpayKeyId:process.env.RAZORPAY_KEY_ID||'',razorpayKeySecret:process.env.RAZORPAY_KEY_SECRET||'',webhookSecret:process.env.RAZORPAY_WEBHOOK_SECRET||''};
if(env.jwtSecret.length<32)throw Error('JWT_SECRET must contain at least 32 characters. Configure server/.env');
