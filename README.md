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

#### Additional context after discussion

- Rewarding negative points.
- Under the assumption that the client will always provide a valid email format and number format. I have other important validations, like at-least one of email or phone number has been added. I can add them to cover all bases, the focus was just more on the balance update logic and they can be gated with CORS and other security protocols available to only allow approved clients.
- For negative balance my thought process is that the client is in control of the interactions so the client is just a state updater. So if client asks to create a new order with paid 10000 jpy, to cancel it should send a new order -10000 jpy. As the requirement doesn't ask for additional constraints, this seems like the simplest way to just do purchase and cancel. Here I can make a case for an specific update workflow because the client made some mistake by providing wrong paid value and now the balance is negative. This workflow can recalculate the balance and update it. But I believe this workflow is out of the scope, it is also easier to detect inconsistencies for this logic.

## Examples

#### DTO

```bash
curl --request POST \
  --url http://localhost:4000/orders/new \
  --header 'Content-Type: application/json' \
  --data '{
	"order": {
		"id": "b4d9bb30-8972-4d05-aa5b-39aee91b64ed", // optional
		"paid": 10000.0,
		"currency": "jpy", // optional, default jpy
		"point_percentage": 0.05 // optional, default 0.01
	},
	"customer": {
		"email": "example@lunaris.jp",
		"phone": null
	}
}'
```

#### Purchase

```bash
curl --request POST \
  --url http://localhost:4000/orders/new \
  --header 'Content-Type: application/json' \
  --data '{
	"order": {
		"paid": 10000.0,
		"currency": "jpy",
		"point_percentage": 0.05
	},
	"customer": {
		"email": "example@lunaris.jp",
		"phone": null
	}
}'
```

#### Cancel

```bash
curl --request POST \
  --url http://localhost:4000/orders/new \
  --header 'Content-Type: application/json' \
  --data '{
	"order": {
		"paid": -10000.0,
		"currency": "jpy",
		"point_percentage": 0.05
	},
	"customer": {
		"email": "example@lunaris.jp",
		"phone": null
	}
}'
```
