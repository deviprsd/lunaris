# Lunaris

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Task

Create an API! Primary goal of the API is to award points, based on the value of an order (in JPY), to a customer who can be identified by their email and/or phone number.

Specs:

- Back-end language: Elixir, TypeScript, or JavaScript, with the necessary frameworks and tools needed to create an API. However, if you wish to use a language not listed here, please let us know and we will discuss it!
- All data must be stored in a database of choice
- API must be able to:
  - Process orders and award a set percentage (1% base) in points
  - Fetch a customer balance
  - Add/subtract points of the balance
- Extra: ability to modify the percentage of points awarded

Example of API request that will process orders:

curl -X POST http://localhost:4000/orders/new
-H "Content-Type: application/json"
-d '{"order": {"id": "104fd7e0-a188-4ffd-9af7-20d7876f70ab", "paid": 10000, "currency": "jpy"}, "customer": {"email": "example@lunaris.jp", "phone": null}}'

## Assumption

- The order can a postive payment or negative payment, representing new order or cancellation.
- The same api returns an updated customer with balance and the new order
- Another api `http://localhost:4000/orders/:id` that returns the current state of order and customer details with balance
- Ability to modify can be different for each order, so the order request enables the client to provide the point_percentage `-d '{"order": {..., "point_percentage": 0.05}, ...}'`
- Update/delete/list operations are not required.
- Phone/email validations and granual field validations aren't required, but basic required validations have been implemented.

#### Considerations and/or not implemented

- The client is in control of the balance (positive/negative) and points awarded and the api only updates the state
- Customer can have negative balance? Currently this is possible but can be validate in the service
