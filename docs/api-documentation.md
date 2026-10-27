# API quick reference

All success responses use `{ok:true,data:...}` and errors `{ok:false,error:"..."}`. Bearer JWT required unless marked public.

| Method | Path | Access | Purpose |
|---|---|---|---|
| POST | `/api/auth/register` | Public | Student registration |
| POST | `/api/auth/login` | Public | Get JWT |
| GET | `/api/auth/me` | User | Current account |
| GET | `/api/canteens` | Public | List canteens |
| GET | `/api/categories` | Public | Categories |
| GET | `/api/canteens/:id/menu` | Public | Available menu |
| GET | `/api/canteens/:id/slots?date=YYYY-MM-DD` | Public | Future slots with remaining workload |
| POST | `/api/orders` | Student | Transactional order creation; body `{canteenId,items:[{itemId,quantity}],pickupAt,paymentMethod}` |
| GET | `/api/orders/my` | Student | Own order history |
| GET | `/api/orders/:id` | Owner or assigned staff/admin | Order detail |
| POST | `/api/orders/:id/cancel` | Owner | Cancel before preparation, unpaid only |
| GET | `/api/canteen/orders` | Staff/admin | Assigned canteen queue |
| PATCH | `/api/orders/:id/status` | Staff/admin | Valid lifecycle transition |
| POST | `/api/orders/:id/verify-pickup` | Staff/admin | Verify single-use code |
| POST | `/api/payments/create-order` | Student owner | Create Razorpay server order |
| POST | `/api/payments/verify` | Student owner | Verify HMAC signature |
| POST | `/api/payments/webhook` | Razorpay signature | Idempotent captured-event processing |
| GET | `/api/reports/sales` | Staff/admin | Canteen-level count and paid revenue |
| POST | `/api/reviews` | Student | Review a collected purchased item |

Staff authorization is checked against assignment rows for each resource access. All SQL values use prepared statements.
