# Testing guide

## Local smoke test

1. Run schema and seed SQL. Start server and client. Confirm `/api/health` returns `{"ok":true,...}`.
2. Register two students. Log in, browse all canteens/menu, add food, select a future slot, place pay-at-pickup order. Save the displayed pickup code.
3. Promote a test account to staff with the SQL in `seed.sql` and assign one canteen. Log in as staff, confirm the order, progress it through PREPARING and READY, verify the code. Confirm a repeated code fails.
4. Student checks order history/detail and cannot access another account's order. Try an invalid transition and an unavailable slot; both should fail.
5. Set Razorpay test credentials, create a RAZORPAY order, use provider test checkout, and confirm signature verification. Replay webhook event; unique id should make it idempotent.
6. Run `database/reports.sql` with a valid student id for history and inspect revenue/popularity results.

## Automated checks

Run `npm.cmd run check` in server and `npm.cmd run build` in client. Concurrency behavior should also be exercised by submitting two orders for the same final stock unit/slot from separate sessions: only the transaction with remaining capacity should commit.
