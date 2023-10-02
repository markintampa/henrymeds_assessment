# README

Rails 6.1.4

## Setup:
 * bundle install
 * rails db:create, db:migrate
 * rails s to start

# REQUESTS

## Provider create slots:
* POST localhost:3000/appointment_slots

* body: 
  ```
  {
    "appointment_slot": {
      "provider_id": "1",
      "start_time": "2023-10-05 8am",
      "end_time": "2023-10-05 4pm"
    }
  }

## List available slots
* GET localhost:3000/appointment_slots

## Reserve slot
* PUT localhost:3000/appointment_slots/(:slot_id)

* body:
  ```
  {
    "client_id": "1"
  }

## Confirm slot
* PUT localhost:3000/appointment_slots/30/confirm

* body:
  ```
  {
    "client_id": 1
  }
  ```

# Remaining things to do and improve 

* Build out more robust relations (Provider has_many appointment_slots, Client has_many appointments)
* Specs, build out tests for the availability logic & queries, include factories to generate test data
* Finish out error handling
* Add data validations to the models
* Add ability for providers/clients to cancel, reschedule, change availability
* Add ability for providers/clients to query upcoming scheduled appointments
* Add scoping via auth to client/provider to limit any updates to the specific client/provider

# Closing

* Thank you for the opportunity!