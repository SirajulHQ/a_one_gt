final List<Map<String, dynamic>> orders = [
  {
    "orderId": "#A1B2C3",
    "date": "12 Mar 2026",
    "price": 499,
    "status": "Delivered",
    "items": [
      {"name": "Chicken Burger", "price": 299},
      {"name": "Pepsi", "price": 200},
    ],
    "address": "Dubai Marina",
    "isExpanded": false,
  },
  {
    "orderId": "#X7Y8Z9",
    "date": "10 Mar 2026",
    "price": 599, // Updated price after partial return
    "status": "Delivered",
    "items": [
      {"name": "Pizza", "price": 599},
      // Fries was returned
    ],
    "address": "JLT Cluster A",
    "isExpanded": false,
    "partialReturn": {
      "returnedItems": [
        {"name": "Fries", "price": 300},
      ],
      "returnReason": "Poor quality",
      "refundAmount": 300,
    },
  },
  {
    "orderId": "#P4Q5R6",
    "date": "05 Mar 2026",
    "price": 0, // Fully returned
    "status": "Returned",
    "items": [
      {"name": "Sandwich", "price": 299},
    ],
    "address": "Downtown Dubai",
    "isExpanded": false,
    "returnReason": "Changed my mind",
  },
  {
    "orderId": "#M9N8O7",
    "date": "08 Mar 2026",
    "price": 399, // Updated price after partial return (Pizza + Coke)
    "status": "Delivered",
    "items": [
      {"name": "Large Pizza", "price": 299},
      {"name": "Coke", "price": 100},
      // Fries and Burger were returned
    ],
    "address": "Business Bay",
    "isExpanded": false,
    "partialReturn": {
      "returnedItems": [
        {"name": "Fries", "price": 150},
        {"name": "Burger", "price": 250},
      ],
      "returnReason": "Damaged product",
      "refundAmount": 400,
    },
  },
  {
    "orderId": "#T5U6V7",
    "date": "09 Mar 2026",
    "price": 650,
    "status": "Processing",
    "items": [
      {"name": "Grilled Chicken", "price": 350},
      {"name": "Rice Bowl", "price": 200},
      {"name": "Salad", "price": 100},
    ],
    "address": "DIFC",
    "isExpanded": false,
  },
  {
    "orderId": "#K2L3M4",
    "date": "07 Mar 2026",
    "price": 450,
    "status": "Cancelled",
    "items": [
      {"name": "Pasta", "price": 280},
      {"name": "Garlic Bread", "price": 120},
      {"name": "Juice", "price": 50},
    ],
    "address": "Al Barsha",
    "isExpanded": false,
  },
];
