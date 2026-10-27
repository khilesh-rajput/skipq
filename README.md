# SkipQ ? Smart Canteen Ordering

Academic full-stack canteen ordering system: React/Vite, Express, MySQL 8. Uses JWT auth, staff/canteen authorization, price calculations on server, transactional stock and slot capacity, order workflow, hashed pickup codes, reviews, reports and optional Razorpay test payments.

## Request flow
React calls Express with Axios and bearer JWT. Middleware authenticates and checks roles. Services validate business rules and use MySQL2 prepared statements. Order creation locks stock rows and a slot row in one transaction, checks capacity, records purchase price snapshots, reserves inventory and workload, and commits. Razorpay secrets stay server-side; checkout and webhook signatures are checked.

## Setup (Windows PowerShell)
Requirements: Node.js 20+, npm, MySQL 8. Run `database/schema.sql` and `database/seed.sql` in Workbench. Copy `server/.env.example` to `server/.env`, configure MySQL and a JWT secret of 32+ characters.

```powershell
cd server
npm.cmd install
npm.cmd run dev
```

In another terminal:
```powershell
cd client
Copy-Item .env.example .env
npm.cmd install
npm.cmd run dev
```
Open http://localhost:5173. Register a student account in the UI. To provision a staff/admin account for local demos, use the trusted SQL examples at the end of `database/seed.sql`; do not expose a public role picker.

Default `PAYMENT_MODE=mock` disables gateway use; choose pay-at-pickup for local end-to-end testing. This is not an online payment. For test gateway use, configure `PAYMENT_MODE=razorpay`, `RAZORPAY_KEY_ID`, `RAZORPAY_KEY_SECRET`, `RAZORPAY_WEBHOOK_SECRET` on server and `VITE_RAZORPAY_KEY_ID` in client. Set the Razorpay webhook to `/api/payments/webhook` on a publicly reachable development tunnel.

See docs for API, schema/viva notes and manual testing. Demo credentials are not production credentials.
