define ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is match method of the Router
  (match) ->
    match '', 'main#index'
    match 'login', 'user#login'
    match 'logout', 'user#logout'
    match 'profile', 'user#edit'
    match 'settings', 'user#edit'
    match 'new', 'events#add'
    match 'event/:id', 'events#show'